import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';
import '../widgets/image_preview_top_bar.dart';
import '../widgets/image_preview_view.dart';
import '../widgets/image_preview_bottom_actions.dart';
import '../widgets/image_preview_user_selection.dart';
import '../riverpod_providers.dart';
import '../../../friendship/presentation/riverpod_providers.dart';
import '../../../../shared/widgets/measure_size.dart';

class ImagePreviewScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  ConsumerState<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends ConsumerState<ImagePreviewScreen> {
  final TextEditingController _amountController = TextEditingController();
  ExpenseCategory? _selectedCategory;
  bool _useAllFriends = true;
  final Set<String> _selectedFriendIds = <String>{};
  double _topOverlayHeight = 0;
  double _bottomOverlayHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(friendshipProvider.notifier).fetchFriendships();
    });
  }

  void _setTopOverlayHeight(double height) {
    if ((_topOverlayHeight - height).abs() < 0.5) return;
    setState(() => _topOverlayHeight = height);
  }

  void _setBottomOverlayHeight(double height) {
    if ((_bottomOverlayHeight - height).abs() < 0.5) return;
    setState(() => _bottomOverlayHeight = height);
  }

  void _onSend() async {
    final cameraNotifier = ref.read(cameraProvider.notifier);
    try {
      final amount = double.tryParse(_amountController.text);
      final recipientScope = _useAllFriends
          ? 'ALL_FRIENDS'
          : 'SELECTED_FRIENDS';
      final recipientIds = _useAllFriends
          ? null
          : _selectedFriendIds.toList(growable: false);

      if (!_useAllFriends && (recipientIds == null || recipientIds.isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hãy chọn ít nhất 1 người bạn để gửi ảnh'),
          ),
        );
        return;
      }

      final response = await cameraNotifier.sendCapturedPhoto(
        filePath: widget.imagePath,
        amount: amount,
        categoryId: _selectedCategory?.id,
        recipientScope: recipientScope,
        recipientIds: recipientIds,
      );

      if (response != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gửi ảnh thành công!')));
        context.pop(); // Quay lại màn hình camera
      }
    } catch (e) {
      if (mounted) {
        final fallback = e.toString().replaceAll('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(cameraProvider).sendErrorMessage ?? fallback,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSending = ref.watch(isSendingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. Image Preview (Main content fills background)
          Positioned.fill(
            child: ImagePreviewView(
              imagePath: widget.imagePath,
              amountController: _amountController,
              topOverlayHeight: _topOverlayHeight,
              bottomOverlayHeight: _bottomOverlayHeight,
              onCategoryChanged: (cat) {
                setState(() => _selectedCategory = cat);
              },
            ),
          ),

          // 2. Top Bar (Overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MeasureSize(
              onChange: (size) => _setTopOverlayHeight(size.height),
              child: SafeArea(
                bottom: false,
                child: ImagePreviewTopBar(
                  onDownload: () {
                    // TODO: Implement download logic
                  },
                ),
              ),
            ),
          ),

          // 3. Bottom Controls (Overlay)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MeasureSize(
              onChange: (size) => _setBottomOverlayHeight(size.height),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagePreviewBottomActions(
                      onClose: () => context.pop(),
                      onSend: _onSend,
                      onTypeText: () {
                        // Focus amount controller or other text logic
                      },
                    ),
                    const SizedBox(height: 40),
                    ImagePreviewUserSelection(
                      useAllFriends: _useAllFriends,
                      selectedFriendIds: _selectedFriendIds,
                      onSelectAll: () {
                        setState(() {
                          _useAllFriends = true;
                          _selectedFriendIds.clear();
                        });
                      },
                      onToggleFriend: (friendId) {
                        setState(() {
                          _useAllFriends = false;
                          if (_selectedFriendIds.contains(friendId)) {
                            _selectedFriendIds.remove(friendId);
                          } else {
                            _selectedFriendIds.add(friendId);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // 4. Sending overlay
          if (isSending)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFD35A)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
