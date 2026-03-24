import 'package:flutter/material.dart';

/// A reusable bottom sheet for updating the user's first and last name.
///
/// Returns a record `({String firstName, String lastName})`, or `null` if dismissed.
class NameInputBottomSheet extends StatefulWidget {
  final String? currentFirstName;
  final String? currentLastName;

  const NameInputBottomSheet({
    super.key,
    this.currentFirstName,
    this.currentLastName,
  });

  /// Shows the name input bottom sheet and returns the entered names.
  ///
  /// Returns `null` if the user dismisses without confirming.
  static Future<({String firstName, String lastName})?> show(
    BuildContext context, {
    String? currentFirstName,
    String? currentLastName,
  }) {
    return showModalBottomSheet<({String firstName, String lastName})>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NameInputBottomSheet(
        currentFirstName: currentFirstName,
        currentLastName: currentLastName,
      ),
    );
  }

  @override
  State<NameInputBottomSheet> createState() => _NameInputBottomSheetState();
}

class _NameInputBottomSheetState extends State<NameInputBottomSheet> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.currentFirstName);
    _lastNameController = TextEditingController(text: widget.currentLastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _submit() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    if (firstName.isEmpty || lastName.isEmpty) return;
    Navigator.of(context).pop((firstName: firstName, lastName: lastName));
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

            // First name field
            TextField(
              controller: _firstNameController,
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: 'Họ',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Last name field
            TextField(
              controller: _lastNameController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: 'Tên',
                hintStyle: const TextStyle(color: Colors.white70),
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
                  'Xác nhận đổi tên',
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
