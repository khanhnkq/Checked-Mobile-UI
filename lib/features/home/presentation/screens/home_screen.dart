import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/photo_models.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/history_top_bar.dart';
import '../widgets/home_camera_view.dart';
import '../widgets/home_bottom_controls.dart';
import 'photo_detail_screen.dart';
import '../providers/photo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  // Dùng ValueNotifier thay vì setState → chỉ top bar area rebuild khi đổi trang
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage.value) {
        _currentPage.value = page;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PhotoProvider>().fetchPhotos();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar dùng chung cho tất cả trang trong PageView.
            // ValueListenableBuilder đảm bảo chỉ phần này rebuild khi đổi trang,
            // còn mỗi TopBar tự dùng Selector nên không rebuild theo provider.
            ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, page, _) =>
                  page == 0 ? const HomeTopBar() : const HistoryTopBar(),
            ),

            // Chỉ phần PageView mới rebuild khi danh sách ảnh thay đổi
            Expanded(
              child: Selector<PhotoProvider, List<PhotoResponse>>(
                selector: (_, provider) => provider.photos,
                builder: (context, photos, child) {
                  return PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: 1 + photos.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildCameraContent();
                      } else {
                        final photo = photos[index - 1];
                        return PhotoDetailContent(
                          photo: photo,
                          onBackToCamera: () {
                            _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraContent() {
    return Column(
      children: [
        const Spacer(),
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: HomeCameraView(),
          ),
        ),
        const Spacer(),
        const HomeBottomControls(),
        const SizedBox(height: 40),
      ],
    );
  }
}

/// Tách riêng nội dung Detail để không chứa Scaffold và Top Bar
class PhotoDetailContent extends StatelessWidget {
  final dynamic photo;
  final VoidCallback onBackToCamera;

  const PhotoDetailContent({
    super.key,
    required this.photo,
    required this.onBackToCamera,
  });

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays >= 1) return '${difference.inDays}ngày';
    if (difference.inHours >= 1) return '${difference.inHours}giờ';
    if (difference.inMinutes >= 1) return '${difference.inMinutes}phút';
    return 'vừa xong';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isMe = photo.senderId == authProvider.authResponse?.id;

    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    photo.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                if (photo.caption != null && photo.caption!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        photo.caption!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${isMe ? "Bạn" : photo.senderDisplayName} ${_getTimeAgo(photo.takenAt)}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
        _buildActivityButton(photo),
        const Spacer(),
        _buildBottomControls(context),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildActivityButton(dynamic photo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          const Text('Hoạt động', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 12,
            backgroundImage: photo.senderAvatarUrl != null ? NetworkImage(photo.senderAvatarUrl!) : null,
            child: photo.senderAvatarUrl == null ? const Icon(Icons.person, size: 12) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 32),
            onPressed: () {
              // Mở grid màn hình riêng
            },
          ),
          // Giả lập nút chụp để quay lại
          GestureDetector(
            onTap: onBackToCamera,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFD35A), width: 4),
              ),
              child: Center(
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white, size: 32),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
