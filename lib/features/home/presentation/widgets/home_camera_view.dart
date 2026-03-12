import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/camera_provider.dart';

class HomeCameraView extends StatefulWidget {
  const HomeCameraView({super.key});

  @override
  State<HomeCameraView> createState() => _HomeCameraViewState();
}

class _HomeCameraViewState extends State<HomeCameraView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CameraProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (context, cameraProvider, child) {
        return AspectRatio(
          aspectRatio: 1.0, // Đảm bảo khung luôn là hình vuông
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
                  // Camera Preview với logic căn giữa và cắt (crop)
                  cameraProvider.isInitialized && cameraProvider.controller != null
                      ? _buildCameraPreview(cameraProvider.controller!)
                      : Container(
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(color: Color(0xFFFFD35A)),
                          ),
                        ),
                  
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
      },
    );
  }

  Widget _buildCameraPreview(CameraController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Lấy tỷ lệ của camera (thường là landscape, ví dụ 1.77 cho 16:9)
        double cameraAspectRatio = controller.value.aspectRatio;
        
        // Đảm bảo tỷ lệ luôn < 1 cho chế độ Portrait (chiều cao > chiều rộng)
        // Nếu điện thoại trả về 1.77, chúng ta đổi thành 1/1.77 = 0.56
        if (cameraAspectRatio > 1) {
          cameraAspectRatio = 1 / cameraAspectRatio;
        }

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxWidth,
          child: FittedBox(
            fit: BoxFit.cover, // Cắt bỏ phần thừa để lấp đầy khung vuông
            child: SizedBox(
              width: constraints.maxWidth,
              // Chiều cao thực tế của preview camera dựa trên tỷ lệ chuẩn
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
        color: Colors.black.withOpacity(0.3),
      ),
      child: Center(
        child: text != null
            ? Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            : Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
