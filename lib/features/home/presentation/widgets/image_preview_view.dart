import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';
import 'package:locket/features/expense/presentation/riverpod_providers.dart';

class ImagePreviewView extends ConsumerStatefulWidget {
  final String imagePath;
  final TextEditingController amountController;
  final Function(ExpenseCategory?) onCategoryChanged;
  final double topOverlayHeight;
  final double bottomOverlayHeight;

  const ImagePreviewView({
    super.key,
    required this.imagePath,
    required this.amountController,
    required this.onCategoryChanged,
    required this.topOverlayHeight,
    required this.bottomOverlayHeight,
  });

  @override
  ConsumerState<ImagePreviewView> createState() => _ImagePreviewViewState();
}

class _ImagePreviewViewState extends ConsumerState<ImagePreviewView> {
  ExpenseCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseProvider.notifier).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: widget.topOverlayHeight),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Captured Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: FileImage(File(widget.imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Overlays
                Positioned(
                  bottom: 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Category Selection
                      () {
                        final categories = ref.watch(expenseCategoriesProvider);
                        if (categories.isEmpty) return const SizedBox.shrink();

                        return Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            separatorBuilder: (_, index) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final cat = categories[index];
                              final isSelected = _selectedCategory?.id == cat.id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() => _selectedCategory = isSelected ? null : cat);
                                  widget.onCategoryChanged(_selectedCategory);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFFD35A)
                                        : Colors.black.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        isSelected ? null : Border.all(color: Colors.white24),
                                  ),
                                  child: Center(
                                    child: Text(
                                      cat.name,
                                      style: TextStyle(
                                        color: isSelected ? Colors.black : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }(),

                      // Amount Input
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: widget.amountController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Thêm số tiền',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
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
        const Spacer(),
        SizedBox(height: widget.bottomOverlayHeight),
      ],
    );
  }
}
