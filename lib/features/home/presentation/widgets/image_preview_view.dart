import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';
import 'package:locket/features/expense/presentation/riverpod_providers.dart';
import 'package:locket/core/theme/app_colors.dart';

class ImagePreviewView extends ConsumerStatefulWidget {
  final String imagePath;
  final TextEditingController amountController;
  final Function(ExpenseCategory?) onCategoryChanged;
  final double topOverlayHeight;
  final double bottomOverlayHeight;
  final TransactionType transactionType;
  final ValueChanged<TransactionType> onTransactionTypeChanged;

  const ImagePreviewView({
    super.key,
    required this.imagePath,
    required this.amountController,
    required this.onCategoryChanged,
    required this.topOverlayHeight,
    required this.bottomOverlayHeight,
    required this.transactionType,
    required this.onTransactionTypeChanged,
  });

  @override
  ConsumerState<ImagePreviewView> createState() => _ImagePreviewViewState();
}

class _ImagePreviewViewState extends ConsumerState<ImagePreviewView> {
  ExpenseCategory? _selectedCategory;
  static const _selectableTypes = <TransactionType>[
    TransactionType.expense,
    TransactionType.income,
  ];

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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Captured Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    image: DecorationImage(
                      image: FileImage(File(widget.imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Overlays
                Positioned(
                  bottom: 24.h,
                  left: 16.w,
                  right: 16.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Amount Input
                      Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        constraints: BoxConstraints(maxWidth: 240.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.1), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('₫',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextField(
                                controller: widget.amountController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28.sp,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.w900,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Transaction Type Toggle
                      Container(
                        height: 48.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.1), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _selectableTypes.map((type) {
                            final isSelected = widget.transactionType == type;
                            final isExpense = type == TransactionType.expense;
                            final label = isExpense ? 'Chi tiêu' : 'Thu nhập';

                            return GestureDetector(
                              onTap: () {
                                widget.onTransactionTypeChanged(type);
                                // Reset category when changing type
                                setState(() => _selectedCategory = null);
                                widget.onCategoryChanged(null);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isExpense
                                          ? AppColors.primary
                                          : Colors.greenAccent)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.white.withOpacity(0.7),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            );
                          }).toList(growable: false),
                        ),
                      ),

                      // Category Selection
                      () {
                        final allCategories = ref.watch(expenseCategoriesProvider);
                        final filteredCategories = allCategories
                            .where((cat) => cat.transactionType == widget.transactionType)
                            .toList(growable: false);

                        if (filteredCategories.isEmpty) return const SizedBox.shrink();

                        return SizedBox(
                          height: 42.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: filteredCategories.length,
                            separatorBuilder: (_, __) => SizedBox(width: 10.w),
                            itemBuilder: (context, index) {
                              final cat = filteredCategories[index];
                              final isSelected = _selectedCategory?.id == cat.id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() => _selectedCategory = isSelected ? null : cat);
                                  widget.onCategoryChanged(_selectedCategory);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(24.r),
                                    border: Border.all(
                                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      cat.name,
                                      style: TextStyle(
                                        color: isSelected ? Colors.black : Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }(),
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
