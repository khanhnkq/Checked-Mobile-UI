import 'package:logger/logger.dart';

/// Shared logger to keep logs consistent across layers.
final Logger appLogger = Logger(
  printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5, lineLength: 100),
);

