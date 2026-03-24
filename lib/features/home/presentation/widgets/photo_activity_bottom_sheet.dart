import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../data/models/reaction_models.dart';

class PhotoActivityBottomSheet extends StatelessWidget {
  const PhotoActivityBottomSheet({
    super.key,
    required this.reactors,
  });

  final List<ReactionActor> reactors;

  static Future<void> show(BuildContext context, List<ReactionActor> reactors) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PhotoActivityBottomSheet(reactors: reactors),
    );
  }

  Widget _getReactionIcon(ReactionType? type) {
    switch (type) {
      case ReactionType.love:
        // Use LucideIcons.heart with red color instead of text emoji if text emoji doesn't render well.
        return Icon(
          LucideIcons.heart,
          color: Colors.redAccent,
          size: 24.sp,
        );
      case ReactionType.haha:
        return Text('😂', style: TextStyle(fontSize: 24.sp));
      case ReactionType.wow:
        return Text('🔥', style: TextStyle(fontSize: 24.sp));
      case ReactionType.sad:
        return Text('😢', style: TextStyle(fontSize: 24.sp));
      case ReactionType.angry:
        return Text('😡', style: TextStyle(fontSize: 24.sp));
      case ReactionType.like:
      default:
        // Default to a generic like icon if not recognized or null
        return Icon(
          LucideIcons.heart,
          color: Colors.redAccent,
          size: 24.sp,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Hoạt động',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24.h),
            if (reactors.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  'Chưa có hoạt động nào',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14.sp,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                itemBuilder: (context, index) {
                  final actor = reactors[index];
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: const Color(0xFF2A2A2A),
                        backgroundImage: actor.avatarUrl != null
                            ? NetworkImage(actor.avatarUrl!)
                            : null,
                        child: actor.avatarUrl == null
                            ? Icon(
                                LucideIcons.user,
                                color: Colors.white,
                                size: 20.sp,
                              )
                            : null,
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          actor.displayName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      _getReactionIcon(actor.type),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: reactors.length,
              ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
