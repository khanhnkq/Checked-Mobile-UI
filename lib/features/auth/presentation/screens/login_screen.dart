import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/skeleton.dart';
import '../riverpod_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    final authNotifier = ref.read(authProvider.notifier);
    final identifier = _identifierController.text.trim();
    final password = _passwordController.text;

    if (identifier.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    await authNotifier.login(identifier, password);

    if (mounted) {
      setState(() => _isLoading = false);
      
      final authState = ref.read(authProvider);
      if (authState.status == AuthStatus.authenticated) {
        if (authState.isProfileIncomplete) {
          context.go('/complete-profile');
        } else {
          context.go('/home');
        }
      } else if (authState.status == AuthStatus.otpPending) {
        final email = Uri.encodeComponent(authState.pendingEmail ?? identifier);
        context.push('/otp?email=$email');
      } else if (authState.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authState.errorMessage!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              children: [
                const Spacer(flex: 3),
                const Center(
                  child: AppLogo(),
                ),
                const SizedBox(height: 64),
                const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 48),
                CustomTextField(
                  hintText: 'email hoặc username',
                  controller: _identifierController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'mật khẩu',
                  isPassword: true,
                  controller: _passwordController,
                ),
                const Spacer(flex: 2),
                _isLoading
                    ? const SkeletonButton()
                    : PrimaryButton(
                        text: 'Đăng nhập',
                        onPressed: _login,
                      ),
                const Spacer(flex: 3),
                TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
