import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../data/models/photo_models.dart';
import '../../../auth/presentation/riverpod_providers.dart';

class PhotoDetailBody extends ConsumerWidget {
  final PhotoResponse photo;
  final double? topSpacing;

  const PhotoDetailBody({
    super.key,
    required this.photo,
    this.topSpacing,
  });

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays >= 1) return '${difference.inDays}ngày';
    if (difference.inHours >= 1) return '${difference.inHours}giờ';
    if (difference.inMinutes >= 1) return '${difference.inMinutes}phút';
    return 'vừa xong';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserIdProvider);
    final isMe = photo.senderId == currentUserId;
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    // Sử dụng ScreenUtil để tính toán spacing tự động co giãn theo tỉ lệ máy
    // Mặc định là 120.h nếu không truyền vào
    final double effectiveTopSpacing = topSpacing ?? 120.h;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Top spacing dùng đơn vị .h (responsive height)
          SizedBox(height: effectiveTopSpacing),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w), // Responsive width
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r), // Responsive radius
                    child: Image.network(
                      photo.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),

                  // Caption & Amount Overlay
                  Positioned(
                    bottom: 24.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (photo.amount != null && photo.amount! > 0)
                          Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD35A),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              currencyFormat.format(photo.amount),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.sp, // Responsive font size
                              ),
                            ),
                          ),
                        if (photo.caption != null && photo.caption!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              photo.caption!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            '${isMe ? "Bạn" : photo.senderDisplayName} · ${_getTimeAgo(photo.takenAt)}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 24.h),
          _buildActivityButton(photo),
          
          // Khoảng trống linh hoạt ở dưới cùng
          SizedBox(height: 160.h), 
        ],
      ),
    );
  }

  Widget _buildActivityButton(PhotoResponse photo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.sparkles, color: Colors.white, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            'Hoạt động',
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 12.r,
            backgroundImage: photo.senderAvatarUrl != null
                ? NetworkImage(photo.senderAvatarUrl!)
                : null,
            child: photo.senderAvatarUrl == null
                ? Icon(LucideIcons.user, size: 12.sp)
                : null,
          ),
        ],
      ),
    );
  }
}
