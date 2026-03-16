import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:locket/features/expense/presentation/providers/expense_provider.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';

class ImagePreviewView extends StatefulWidget {
  final String imagePath;
  final TextEditingController amountController;
  final Function(ExpenseCategory?) onCategoryChanged;

  const ImagePreviewView({
    super.key,
    required this.imagePath,
    required this.amountController,
    required this.onCategoryChanged,
  });

  @override
  State<ImagePreviewView> createState() => _ImagePreviewViewState();
}

class _ImagePreviewViewState extends State<ImagePreviewView> {
  ExpenseCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  Consumer<ExpenseProvider>(
                    builder: (context, provider, _) {
                      final categories = provider.categories;
                      if (categories.isEmpty) return const SizedBox.shrink();
                      
                      return Container(
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
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
                                  border: isSelected ? null : Border.all(color: Colors.white24),
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
                    },
                  ),

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
    );
  }
}
