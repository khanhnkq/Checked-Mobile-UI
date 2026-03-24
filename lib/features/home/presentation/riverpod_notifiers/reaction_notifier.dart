import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/reaction_models.dart';
import '../../domain/repositories/photo_repository.dart';
import '../../domain/usecases/delete_photo_reaction_usecase.dart';
import '../../domain/usecases/get_photo_reaction_summary_usecase.dart';
import '../../domain/usecases/upsert_photo_reaction_usecase.dart';
import 'reaction_state.dart';

class ReactionNotifier extends StateNotifier<ReactionState> {
  ReactionNotifier({required PhotoRepository repository})
    : _repository = repository,
      super(const ReactionState()) {
    _getSummaryUseCase = GetPhotoReactionSummaryUseCase(_repository);
    _upsertUseCase = UpsertPhotoReactionUseCase(_repository);
    _deleteUseCase = DeletePhotoReactionUseCase(_repository);
  }

  final PhotoRepository _repository;
  late final GetPhotoReactionSummaryUseCase _getSummaryUseCase;
  late final UpsertPhotoReactionUseCase _upsertUseCase;
  late final DeletePhotoReactionUseCase _deleteUseCase;

  Future<void> loadSummary(String photoId, {bool force = false}) async {
    if (photoId.isEmpty) return;
    if (!force && state.summaryByPhotoId.containsKey(photoId)) return;
    if (state.loadingPhotoIds.contains(photoId)) return;

    final loading = {...state.loadingPhotoIds, photoId};
    final errors = {...state.errorByPhotoId}..remove(photoId);
    state = state.copyWith(loadingPhotoIds: loading, errorByPhotoId: errors);

    try {
      final summary = await _getSummaryUseCase.call(photoId);
      final summaries = {...state.summaryByPhotoId, photoId: summary};
      final doneLoading = {...state.loadingPhotoIds}..remove(photoId);
      state = state.copyWith(
        summaryByPhotoId: summaries,
        loadingPhotoIds: doneLoading,
      );
    } catch (e) {
      final doneLoading = {...state.loadingPhotoIds}..remove(photoId);
      final nextErrors = {
        ...state.errorByPhotoId,
        photoId: e.toString().replaceAll('Exception: ', ''),
      };
      state = state.copyWith(
        loadingPhotoIds: doneLoading,
        errorByPhotoId: nextErrors,
      );
    }
  }

  Future<void> toggleReaction(String photoId, ReactionType type) async {
    if (photoId.isEmpty || state.pendingPhotoIds.contains(photoId)) return;

    final pending = {...state.pendingPhotoIds, photoId};
    final errors = {...state.errorByPhotoId}..remove(photoId);
    state = state.copyWith(pendingPhotoIds: pending, errorByPhotoId: errors);

    try {
      final current = state.summaryByPhotoId[photoId];
      if (current != null && current.myReaction == type) {
        await _deleteUseCase.call(photoId);
      } else {
        await _upsertUseCase.call(photoId, type);
      }
      await loadSummary(photoId, force: true);
    } catch (e) {
      final nextErrors = {
        ...state.errorByPhotoId,
        photoId: e.toString().replaceAll('Exception: ', ''),
      };
      state = state.copyWith(errorByPhotoId: nextErrors);
    } finally {
      final donePending = {...state.pendingPhotoIds}..remove(photoId);
      state = state.copyWith(pendingPhotoIds: donePending);
    }
  }
}
