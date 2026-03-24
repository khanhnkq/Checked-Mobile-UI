import 'package:flutter/material.dart';

/// A reusable bottom sheet for entering/updating the monthly budget limit.
///
/// Returns the entered budget limit as a [double], or `null` if dismissed.
class BudgetInputBottomSheet extends StatefulWidget {
  final double? currentLimit;

  const BudgetInputBottomSheet({super.key, this.currentLimit});

  /// Shows the budget input bottom sheet and returns the entered limit.
  ///
  /// Returns `null` if the user dismisses without confirming.
  static Future<double?> show(BuildContext context, {double? currentLimit}) {
    return showModalBottomSheet<double>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BudgetInputBottomSheet(currentLimit: currentLimit),
    );
  }

  @override
  State<BudgetInputBottomSheet> createState() => _BudgetInputBottomSheetState();
}

class _BudgetInputBottomSheetState extends State<BudgetInputBottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.currentLimit?.toInt().toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final limit = double.tryParse(_controller.text);
    if (limit == null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập hạn mức hợp lệ')),
      );
      return;
    }
    Navigator.of(context).pop(limit);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
        decoration: const BoxDecoration(
          color: Color(0xFF2B2B2F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 64,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.32),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 24),

            // Input field
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: 'Nhập hạn mức',
                hintStyle: const TextStyle(color: Colors.white70),
                suffixText: '₫',
                suffixStyle: const TextStyle(color: Color(0xFFF5CD47)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5CD47),
                  foregroundColor: const Color(0xFF1A1A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Xác nhận hạn mức',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
