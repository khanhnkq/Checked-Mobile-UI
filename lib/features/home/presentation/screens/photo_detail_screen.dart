import 'package:flutter/material.dart';
import '../../data/models/photo_models.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/detail_bottom_controls.dart';
import '../widgets/photo_detail_body.dart';
import 'history_grid_screen.dart';
import 'home_screen.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoResponse photo;
  final VoidCallback? onBackToCamera;

  const PhotoDetailScreen({
    super.key,
    required this.photo,
    this.onBackToCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: SafeArea(
        child: Column(
          children: [
            // Self-contained — tự đọc provider qua Selector, không re-render theo provider khác
            const HistoryTopBar(),
            Expanded(
              child: Stack(
                children: [
                  PhotoDetailBody(photo: photo),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DetailBottomControls(
                      onOpenGrid: () async {
                        final selectedPhotoId = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryGridScreen(),
                          ),
                        );

                        if (!context.mounted || selectedPhotoId == null) {
                          return;
                        }

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              initialPhotoId: selectedPhotoId,
                            ),
                          ),
                        );
                      },
                      onPrimaryAction: onBackToCamera ?? () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

