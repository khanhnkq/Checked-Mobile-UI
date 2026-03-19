import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/expense/presentation/providers/expense_provider.dart';
import '../features/home/presentation/providers/camera_provider.dart';
import '../features/home/presentation/providers/photo_provider.dart';

List<SingleChildWidget> buildAppProviders() {
  return [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => CameraProvider()),
    ChangeNotifierProvider(create: (_) => PhotoProvider()),
    ChangeNotifierProvider(create: (_) => ExpenseProvider()),
  ];
}

