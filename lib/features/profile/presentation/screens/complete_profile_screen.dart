import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/skeleton.dart';
import '../../../auth/presentation/riverpod_providers.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;

  void _onComplete() async {
    final authNotifier = ref.read(authProvider.notifier);
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() => _isLoading = true);
    final success = await authNotifier.completeProfile(
      firstName: firstName,
      lastName: lastName,
      // Username đã được tạo từ bước Register nên không cần gửi lại ở đây nếu Backend không yêu cầu
    );
    
    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        context.go('/home');
      } else {
        final authState = ref.read(authProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authState.errorMessage ?? 'Cập nhật thất bại')),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                const AppLogo(size: 100),
                const SizedBox(height: 40),
                const Text(
                  'Hoàn tất hồ sơ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Hãy cho chúng tôi biết tên của bạn để bạn bè có thể nhận ra.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                CustomTextField(
                  hintText: 'Họ',
                  controller: _lastNameController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Tên',
                  controller: _firstNameController,
                ),
                const SizedBox(height: 60),
                _isLoading
                    ? const SkeletonButton()
                    : PrimaryButton(
                        text: 'Tiếp tục',
                        onPressed: _onComplete,
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
