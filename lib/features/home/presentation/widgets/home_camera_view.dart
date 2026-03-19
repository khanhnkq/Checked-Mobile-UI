import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_providers.dart';

class HomeCameraView extends ConsumerStatefulWidget {
  const HomeCameraView({super.key});

  @override
  ConsumerState<HomeCameraView> createState() => _HomeCameraViewState();
}

class _HomeCameraViewState extends ConsumerState<HomeCameraView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(cameraProvider.notifier).initialize();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraProvider);
    final controller = cameraState.controller;
    final bool isInitialized = cameraState.isInitialized && 
                               controller != null && 
                               controller.value.isInitialized;

    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (isInitialized)
                _buildCameraPreview(controller)
              else
                const ColoredBox(color: Colors.black),
              
              // Top Overlay Buttons
              Positioned(
                top: 20,
                left: 20,
                child: _buildCircleButton(Icons.flash_on),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: _buildCircleButton(Icons.one_x_mobiledata_rounded, text: '1x'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPreview(CameraController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Lấy tỷ lệ của camera an toàn hơn
        double cameraAspectRatio = 1.0;
        try {
          if (controller.value.isInitialized) {
            cameraAspectRatio = controller.value.aspectRatio;
          }
        } catch (_) {
          cameraAspectRatio = 1.0;
        }
        
        if (cameraAspectRatio > 1) {
          cameraAspectRatio = 1 / cameraAspectRatio;
        }

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxWidth,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxWidth / cameraAspectRatio,
              child: CameraPreview(controller),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircleButton(IconData icon, {String? text}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.3),
      ),
      child: Center(
        child: text != null
            ? Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            : Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
