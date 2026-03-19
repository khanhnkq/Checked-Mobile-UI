import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/photo_models.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/detail_bottom_controls.dart';
import '../widgets/photo_detail_body.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoResponse photo;
  final VoidCallback? onBackToCamera;
  final double topSpacing;

  const PhotoDetailScreen({
    super.key,
    required this.photo,
    this.onBackToCamera,
    this.topSpacing = 200, // Bạn có thể chỉnh mặc định ở đây hoặc truyền vào khi gọi
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: Stack(
        children: [
          // 1. Content fills the background
          Positioned.fill(
            child: PhotoDetailBody(
              photo: photo,
              topSpacing: topSpacing, // Sử dụng giá trị từ constructor
            ),
          ),

          // 2. Header (Overlay)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: const HistoryTopBar(),
            ),
          ),

           // 3. Bottom controls (Overlay)
           Align(
             alignment: Alignment.bottomCenter,
             child: SafeArea(
               top: false,
               child: DetailBottomControls(
                 onOpenGrid: () {
                   context.push('/history');
                 },
                 onPrimaryAction: onBackToCamera ?? () => context.pop(),
               ),
             ),
           ),
        ],
      ),
    );
  }
}
