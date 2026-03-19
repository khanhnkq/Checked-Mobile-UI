import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/app_settings_model.dart';
import '../../../../core/storage/app_settings_repository.dart';

final appSettingsRepositoryProvider = Provider<AppSettingsRepository>(
  (ref) => AppSettingsRepository(),
);

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettingsModel>(
  (ref) => AppSettingsNotifier(ref.read(appSettingsRepositoryProvider)),
);

class AppSettingsNotifier extends StateNotifier<AppSettingsModel> {
  AppSettingsNotifier(this._repository) : super(_repository.read());

  final AppSettingsRepository _repository;

  Future<void> setStreaksEnabled(bool value) async {
    final next = state.copyWith(streaksEnabled: value);
    state = next;
    await _repository.save(next);
  }
}

