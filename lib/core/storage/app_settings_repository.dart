import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/app_settings_model.dart';

class AppSettingsRepository {
  static const String _boxName = 'app_settings';
  static const String _settingsKey = 'settings';

  Box<dynamic> get _box => Hive.box<dynamic>(_boxName);

  AppSettingsModel read() {
    final raw = _box.get(_settingsKey);
    if (raw is String && raw.isNotEmpty) {
      return AppSettingsModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    }
    return const AppSettingsModel();
  }

  Future<void> save(AppSettingsModel settings) async {
    await _box.put(_settingsKey, jsonEncode(settings.toJson()));
  }
}

