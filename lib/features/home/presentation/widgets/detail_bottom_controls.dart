import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../shared/widgets/capture_button.dart';

class DetailBottomControls extends StatelessWidget {
  final VoidCallback onOpenGrid;
  final VoidCallback onPrimaryAction;
  final VoidCallback? onShare;
  final EdgeInsetsGeometry padding;

  const DetailBottomControls({
    super.key,
    required this.onOpenGrid,
    required this.onPrimaryAction,
    this.onShare,
    this.padding = const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                LucideIcons.layoutGrid,
                color: Colors.white,
                size: 32,
              ),
              onPressed: onOpenGrid,
            ),
            CaptureButton(onTap: onPrimaryAction, size: 80),
            IconButton(
              icon: const Icon(
                LucideIcons.share2,
                color: Colors.white,
                size: 32,
              ),
              onPressed: onShare ?? () => context.push('/expense'),
            ),
          ],
        ),
      ),
    );
  }
}
