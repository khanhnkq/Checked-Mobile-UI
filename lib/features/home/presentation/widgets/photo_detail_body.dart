import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../data/models/photo_models.dart';
import '../../data/models/reaction_models.dart';
import '../riverpod_providers.dart';
import '../../../auth/presentation/riverpod_providers.dart';
import 'photo_activity_bottom_sheet.dart';

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
    final currentUserAvatarUrl = ref.watch(userProfileProvider)?.avatarUrl;
    final isMe = photo.senderId == currentUserId;
    final senderAvatarUrl = isMe ? currentUserAvatarUrl : photo.senderAvatarUrl;
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32), // Responsive width
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundImage: senderAvatarUrl != null
                    ? NetworkImage(senderAvatarUrl)
                    : null,
                child: senderAvatarUrl == null
                    ? Icon(LucideIcons.user, size: 12.sp)
                    : null,
              ),
              SizedBox(width: 8.w),
              Text(
                '${isMe ? "Bạn" : photo.senderDisplayName} · ${_getTimeAgo(photo.takenAt)}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _PhotoEngagementSection(photo: photo, isMe: isMe),
          
          // Khoảng trống linh hoạt ở dưới cùng
          SizedBox(height: 160.h), 
        ],
      ),
    );
  }
}

class _PhotoEngagementSection extends ConsumerStatefulWidget {
  const _PhotoEngagementSection({required this.photo, required this.isMe});

  final PhotoResponse photo;
  final bool isMe;

  @override
  ConsumerState<_PhotoEngagementSection> createState() =>
      _PhotoEngagementSectionState();
}

class _PhotoEngagementSectionState
    extends ConsumerState<_PhotoEngagementSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reactionProvider.notifier).loadSummary(widget.photo.id);
    });
  }

  @override
  void didUpdateWidget(covariant _PhotoEngagementSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photo.id != widget.photo.id) {
      ref.read(reactionProvider.notifier).loadSummary(widget.photo.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(photoReactionSummaryProvider(widget.photo.id));

    if (widget.isMe) {
      return _OwnerActivityPanel(summary: summary);
    }

    return _ReactionComposer(photoId: widget.photo.id, summary: summary);
  }
}

class _OwnerActivityPanel extends StatelessWidget {
  const _OwnerActivityPanel({required this.summary});

  final PhotoReactionSummary? summary;

  @override
  Widget build(BuildContext context) {
    final hasReaction = (summary?.totalCount ?? 0) > 0;
    final reactors = summary?.recentReactors ?? const <ReactionActor>[];

    Widget child;
    if (!hasReaction) {
      child = Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.sparkles, color: Colors.white70, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              'Chưa có hoạt động nào',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      child = Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.sparkles, color: Colors.white70, size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              'Hoạt động',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(width: 8.w),
            if (reactors.isEmpty)
              Text(
                '${summary?.totalCount ?? 0} người đã reaction',
                style: TextStyle(color: Colors.white70, fontSize: 12.sp),
              )
            else
              _InlineReactorAvatars(
                reactors: reactors,
                totalCount: summary!.totalCount,
              ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => PhotoActivityBottomSheet.show(context, reactors),
      child: child,
    );
  }
}

class _InlineReactorAvatars extends StatelessWidget {
  const _InlineReactorAvatars({
    required this.reactors,
    required this.totalCount,
  });

  final List<ReactionActor> reactors;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final visible = reactors.take(3).toList(growable: false);
    final extraCount = totalCount - visible.length;

    return SizedBox(
      height: 24.h,
      width: (visible.length * 14 + (extraCount > 0 ? 26 : 0) + 10).w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: (i * 14).w,
              child: _ReactionAvatar(avatarUrl: visible[i].avatarUrl),
            ),
          if (extraCount > 0)
            Positioned(
              left: (visible.length * 14).w,
              child: Container(
                width: 22.w,
                height: 22.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.24),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF12110B), width: 1),
                ),
                child: Text(
                  '+$extraCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ReactionAvatar extends StatelessWidget {
  const _ReactionAvatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF12110B), width: 1),
      ),
      child: CircleAvatar(
        radius: 11.r,
        backgroundColor: const Color(0xFF2A2A2A),
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null
            ? Icon(LucideIcons.user, color: Colors.white, size: 11.sp)
            : null,
      ),
    );
  }
}

class _ReactionComposer extends ConsumerWidget {
  const _ReactionComposer({required this.photoId, required this.summary});

  final String photoId;
  final PhotoReactionSummary? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPending = ref.watch(photoReactionPendingProvider(photoId));
    final error = ref.watch(photoReactionErrorProvider(photoId));
    final notifier = ref.read(reactionProvider.notifier);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Gửi tin nhắn...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _ReactionChip(
                icon: LucideIcons.heart,
                selected: summary?.myReaction == ReactionType.love,
                onTap: isPending
                    ? null
                    : () => notifier.toggleReaction(photoId, ReactionType.love),
              ),
              SizedBox(width: 8.w),
              _ReactionChip(
                icon: LucideIcons.flame,
                selected: summary?.myReaction == ReactionType.wow,
                onTap: isPending
                    ? null
                    : () => notifier.toggleReaction(photoId, ReactionType.wow),
              ),
              SizedBox(width: 8.w),
              _ReactionChip(
                icon: LucideIcons.smile,
                selected: summary?.myReaction == ReactionType.haha,
                onTap: isPending
                    ? null
                    : () => notifier.toggleReaction(photoId, ReactionType.haha),
              ),
              SizedBox(width: 8.w),
              Icon(
                LucideIcons.smilePlus,
                color: Colors.white.withValues(alpha: 0.9),
                size: 28.sp,
              ),
            ],
          ),
          if (error != null && error.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              error,
              style: TextStyle(color: Colors.redAccent, fontSize: 11.sp),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReactionChip extends StatelessWidget {
  const _ReactionChip({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFD35A).withValues(alpha: 0.22)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(icon, size: 26.sp, color: Colors.white),
      ),
    );
  }
}
