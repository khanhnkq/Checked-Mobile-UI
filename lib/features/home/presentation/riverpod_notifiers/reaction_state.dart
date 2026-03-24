import '../../data/models/reaction_models.dart';

class ReactionState {
  const ReactionState({
    this.summaryByPhotoId = const {},
    this.loadingPhotoIds = const {},
    this.pendingPhotoIds = const {},
    this.errorByPhotoId = const {},
  });

  final Map<String, PhotoReactionSummary> summaryByPhotoId;
  final Set<String> loadingPhotoIds;
  final Set<String> pendingPhotoIds;
  final Map<String, String> errorByPhotoId;

  ReactionState copyWith({
    Map<String, PhotoReactionSummary>? summaryByPhotoId,
    Set<String>? loadingPhotoIds,
    Set<String>? pendingPhotoIds,
    Map<String, String>? errorByPhotoId,
  }) {
    return ReactionState(
      summaryByPhotoId: summaryByPhotoId ?? this.summaryByPhotoId,
      loadingPhotoIds: loadingPhotoIds ?? this.loadingPhotoIds,
      pendingPhotoIds: pendingPhotoIds ?? this.pendingPhotoIds,
      errorByPhotoId: errorByPhotoId ?? this.errorByPhotoId,
    );
  }
}
