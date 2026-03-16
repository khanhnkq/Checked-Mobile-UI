import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:locket/main.dart';
import 'package:locket/features/auth/presentation/providers/auth_provider.dart';
import 'package:locket/features/home/presentation/providers/camera_provider.dart';
import 'package:locket/features/home/presentation/providers/photo_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const storageChannel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUp(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, (call) async {
      if (call.method == 'read') {
        return null;
      }
      if (call.method == 'write' || call.method == 'delete' || call.method == 'deleteAll') {
        return null;
      }
      return null;
    });
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, null);
  });

  testWidgets('renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CameraProvider()),
          ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('email hoặc username'), findsOneWidget);
    expect(find.text('mật khẩu'), findsOneWidget);
    expect(find.text('Đăng ký'), findsOneWidget);
  });
}
