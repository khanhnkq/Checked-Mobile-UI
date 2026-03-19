import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/skeleton.dart';
import '../riverpod_providers.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  final String email;

  const OtpVerifyScreen({super.key, required this.email});

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _verifyOtp() async {
    final authNotifier = ref.read(authProvider.notifier);
    
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập mã OTP 6 số')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    await authNotifier.verifyOtp(widget.email, _otpController.text);

    if (mounted) {
      setState(() => _isLoading = false);
      
      final authState = ref.read(authProvider);
      if (authState.status == AuthStatus.authenticated) {
        if (authState.isProfileIncomplete) {
          context.go('/complete-profile');
        } else {
          context.go('/home');
        }
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
                  'Xác thực OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Mã OTP đã được gửi đến\n${widget.email}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                CustomTextField(
                  hintText: 'Mã OTP (6 số)',
                  controller: _otpController,
                ),
                const Spacer(flex: 2),
                _isLoading
                    ? const SkeletonButton()
                    : PrimaryButton(
                        text: 'Xác nhận',
                        onPressed: _verifyOtp,
                      ),
                const Spacer(flex: 3),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Gửi lại mã',
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
