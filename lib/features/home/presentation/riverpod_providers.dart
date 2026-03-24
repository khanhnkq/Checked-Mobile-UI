import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_locator.dart';
import 'riverpod_notifiers/camera_notifier.dart';
import 'riverpod_notifiers/camera_state.dart';
import 'riverpod_notifiers/photo_notifier.dart';
import 'riverpod_notifiers/photo_state.dart';
import 'riverpod_notifiers/reaction_notifier.dart';
import 'riverpod_notifiers/reaction_state.dart';

// Camera Provider
final cameraProvider = StateNotifierProvider<CameraNotifier, CameraState>((
  ref,
) {
  return CameraNotifier(repository: ref.watch(cameraRepositoryProvider));
});

// Photo/Feed Provider
final photoProvider = StateNotifierProvider<PhotoNotifier, PhotoState>((ref) {
  return PhotoNotifier(repository: ref.watch(photoRepositoryProvider));
});

final reactionProvider = StateNotifierProvider<ReactionNotifier, ReactionState>(
  (ref) {
    return ReactionNotifier(repository: ref.watch(photoRepositoryProvider));
  },
);

// Selector providers for easier consumption
final cameraControllerProvider = Provider((ref) {
  return ref.watch(cameraProvider).controller;
});

final cameraInitializedProvider = Provider((ref) {
  return ref.watch(cameraProvider).isInitialized;
});

final isSendingProvider = Provider((ref) {
  return ref.watch(cameraProvider).isSending;
});

final sendErrorMessageProvider = Provider((ref) {
  return ref.watch(cameraProvider).sendErrorMessage;
});

final photosProvider = Provider((ref) {
  return ref.watch(photoProvider).photos;
});

final photoIsLoadingProvider = Provider((ref) {
  return ref.watch(photoProvider).isLoading;
});

final photoErrorMessageProvider = Provider((ref) {
  return ref.watch(photoProvider).errorMessage;
});

final photoFilterProvider = Provider((ref) {
  return ref.watch(photoProvider).currentFilter;
});

final photoSelectedFriendIdProvider = Provider((ref) {
  return ref.watch(photoProvider).selectedFriendId;
});

final photoHasMoreProvider = Provider((ref) {
  return ref.watch(photoProvider).hasMore;
});

final photoReactionSummaryProvider = Provider.family((ref, String photoId) {
  return ref.watch(reactionProvider).summaryByPhotoId[photoId];
});

final photoReactionLoadingProvider = Provider.family((ref, String photoId) {
  return ref.watch(reactionProvider).loadingPhotoIds.contains(photoId);
});

final photoReactionPendingProvider = Provider.family((ref, String photoId) {
  return ref.watch(reactionProvider).pendingPhotoIds.contains(photoId);
});

final photoReactionErrorProvider = Provider.family((ref, String photoId) {
  return ref.watch(reactionProvider).errorByPhotoId[photoId];
});
