import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/expense/data/repositories/expense_repository_impl.dart';
import '../../features/expense/data/services/expense_service.dart';
import '../../features/expense/domain/repositories/expense_repository.dart';
import '../../features/home/data/repositories/camera_repository_impl.dart';
import '../../features/home/data/repositories/photo_repository_impl.dart';
import '../../features/home/data/services/device_camera_service.dart';
import '../../features/home/data/services/photo_service.dart';
import '../../features/home/domain/repositories/camera_repository.dart';
import '../../features/home/domain/repositories/photo_repository.dart';
import '../../features/profile/data/services/profile_service.dart';
import '../network/dio_client.dart';
import '../storage/secure_storage_service.dart';

/// Centralized service locator using Riverpod providers.
///
/// Keep this file focused on infrastructure wiring so feature notifiers
/// can receive repositories via DI instead of self-instantiating them.

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final dioProvider = Provider<Dio>((ref) {
  return ref.watch(dioClientProvider).dio;
});

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    dio: ref.watch(dioProvider),
    storageService: ref.watch(secureStorageServiceProvider),
  );
});

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService(dio: ref.watch(dioProvider));
});

final photoServiceProvider = Provider<PhotoService>((ref) {
  return PhotoService(dio: ref.watch(dioProvider));
});

final expenseServiceProvider = Provider<ExpenseService>((ref) {
  return ExpenseService(dio: ref.watch(dioProvider));
});

final deviceCameraServiceProvider = Provider<DeviceCameraService>((ref) {
  return DeviceCameraService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authService: ref.watch(authServiceProvider),
    profileService: ref.watch(profileServiceProvider),
    storageService: ref.watch(secureStorageServiceProvider),
  );
});

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepositoryImpl(
    deviceCameraService: ref.watch(deviceCameraServiceProvider),
    photoService: ref.watch(photoServiceProvider),
  );
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  return PhotoRepositoryImpl(
    photoService: ref.watch(photoServiceProvider),
  );
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepositoryImpl(
    expenseService: ref.watch(expenseServiceProvider),
  );
});
