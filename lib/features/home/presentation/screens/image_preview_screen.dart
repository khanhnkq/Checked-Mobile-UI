import 'package:flutter/material.dart';
import '../widgets/image_preview_top_bar.dart';
import '../widgets/image_preview_view.dart';
import '../widgets/image_preview_bottom_actions.dart';
import '../widgets/image_preview_user_selection.dart';
import '../../data/services/photo_service.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final TextEditingController _amountController = TextEditingController();
  final PhotoService _photoService = PhotoService();
  bool _isSending = false;

  void _onSend() async {
    setState(() => _isSending = true);
    try {
      final amount = double.tryParse(_amountController.text);
      final response = await _photoService.uploadPhoto(
        filePath: widget.imagePath,
        amount: amount,
        recipientScope: 'ALL_FRIENDS',
      );

      if (response != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gửi ảnh thành công!')),
        );
        Navigator.pop(context); // Quay lại màn hình camera
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ImagePreviewTopBar(
                  onDownload: () {
                    // TODO: Implement download logic
                  },
                ),
                const Spacer(),
                ImagePreviewView(
                  imagePath: widget.imagePath,
                  amountController: _amountController,
                ),
                const Spacer(),
                ImagePreviewBottomActions(
                  onClose: () => Navigator.pop(context),
                  onSend: _onSend,
                  onTypeText: () {
                    // Focus amount controller or other text logic
                  },
                ),
                const SizedBox(height: 40),
                const ImagePreviewUserSelection(),
                const SizedBox(height: 20),
              ],
            ),
            if (_isSending)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFD35A)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
