import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';
import 'package:locket/features/expense/presentation/riverpod_providers.dart';
import 'package:locket/features/expense/presentation/widgets/budget_input_bottom_sheet.dart';
import 'package:locket/core/theme/app_colors.dart';

class ExpenseScreen extends ConsumerStatefulWidget {
  const ExpenseScreen({super.key});

  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  late String _currentMonthKey;
  final _currencyFormat = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );
  static const _selectableTypes = <TransactionType>[
    TransactionType.expense,
    TransactionType.income,
  ];

  String _abbrev(double amount) {
    final abs = amount.abs();
    final sign = amount < 0 ? '-' : '';
    if (abs >= 1000000000) return '$sign${(abs / 1000000000).toStringAsFixed(1)} tỷ';
    if (abs >= 1000000) return '$sign${(abs / 1000000).toStringAsFixed(1)}Tr';
    if (abs >= 1000) return '$sign${(abs / 1000).toStringAsFixed(1)}K';
    return '$sign${abs.toStringAsFixed(0)}';
  }

  @override
  void initState() {
    super.initState();
    _currentMonthKey = DateFormat('yyyyMM').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseProvider.notifier).fetchMonthlyData(_currentMonthKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseState = ref.watch(expenseProvider);
    final selectedType = ref.watch(expenseSelectedTypeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Chi tiêu tháng này',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20.sp,
            color: AppColors.text,
          ),
        ),
        leading: IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: AppColors.text, size: 28.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: () {
        if (expenseState.isLoading && expenseState.currentSummary == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final summary = expenseState.currentSummary;
        if (summary == null) return const SizedBox.shrink();

        return RefreshIndicator(
          onRefresh: () => ref
              .read(expenseProvider.notifier)
              .fetchMonthlyData(_currentMonthKey, preferredType: selectedType),
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildTypeFilter(selectedType),
                SizedBox(height: 24.h),
                _buildOverviewCard(summary, selectedType, expenseState.currentCashflow),
                SizedBox(height: 16.h),
                _buildCashflowCard(expenseState.currentCashflow),
                SizedBox(height: 32.h),
                _SectionTitle(title: selectedType == TransactionType.expense ? 'Hạng mục chi tiêu' : 'Nguồn thu nhập'),
                _buildCategoryCard(
                  summary,
                  selectedType,
                  expenseState.currentCashflow,
                ),
                SizedBox(height: 32.h),
                const _SectionTitle(title: 'Lịch sử giao dịch'),
                _buildTransactionList(expenseState.entries),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        );
      }(),
    );
  }

  Widget _buildTypeFilter(TransactionType selectedType) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: _selectableTypes
            .map((type) {
              final isSelected = selectedType == type;
              final label = type == TransactionType.expense
                  ? 'Chi tiêu'
                  : 'Thu nhập';
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(expenseProvider.notifier).selectType(_currentMonthKey, type);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.black : AppColors.textSecondary,
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }

  Widget _buildOverviewCard(ExpenseSummary summary, TransactionType selectedType, CashflowSummary? cashflow) {
    final isExpense = selectedType == TransactionType.expense;
    final label = isExpense ? 'Tổng đã chi' : 'Tổng thu nhập';
    final amount = isExpense
        ? (cashflow?.totalExpense ?? summary.totalSpent)
        : (cashflow?.totalIncome ?? 0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconLabel(icon: LucideIcons.wallet, label: label),
              if (isExpense)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    LucideIcons.settings2,
                    color: AppColors.textSecondary,
                    size: 22.sp,
                  ),
                  onPressed: () => _onEditBudget(),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _currencyFormat.format(amount),
            style: TextStyle(
              fontSize: 38.sp,
              fontWeight: FontWeight.w900,
              color: isExpense ? AppColors.primary : Colors.greenAccent,
            ),
          ),
          if (isExpense) ...[
            SizedBox(height: 24.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: (summary.percentUsed / 100).clamp(0.0, 1.0),
                backgroundColor: AppColors.text.withOpacity(0.08),
                color: summary.budgetExceeded
                    ? Colors.redAccent
                    : AppColors.primary,
                minHeight: 10.h,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tiến độ: ${summary.percentUsed.toStringAsFixed(0)}%',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                if (summary.remaining != null)
                  Text(
                    summary.remaining! >= 0
                        ? 'Còn lại: ${_abbrev(summary.remaining!)}'
                        : 'Vượt: ${_abbrev(summary.remaining!.abs())}',
                    style: TextStyle(
                      color: summary.remaining! >= 0
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    ExpenseSummary summary,
    TransactionType selectedType,
    CashflowSummary? cashflow,
  ) {
    final categories = selectedType == TransactionType.expense
        ? summary.byCategory
        : (cashflow?.incomeByCategory ?? const <CategorySummary>[]);

    final totalAmount = categories.fold(0.0, (sum, cat) => sum + cat.totalAmount);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: categories.isEmpty
          ? Padding(
              padding: EdgeInsets.all(24.w),
              child: Center(
                child: Text(
                  'Chưa có dữ liệu',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15.sp),
                ),
              ),
            )
          : Column(
              children: categories.map((cat) {
                final pct = totalAmount > 0 ? cat.totalAmount / totalAmount : 0.0;
                final isExpense = selectedType == TransactionType.expense;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.text.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.tag,
                          color: AppColors.text,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cat.categoryName,
                                  style: TextStyle(color: AppColors.text, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  _currencyFormat.format(cat.totalAmount),
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15.sp, fontWeight: FontWeight.w800),
                                ),
                              ]
                            ),
                            SizedBox(height: 8.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: LinearProgressIndicator(
                                value: pct,
                                backgroundColor: AppColors.text.withOpacity(0.05),
                                color: isExpense ? AppColors.primary : Colors.greenAccent,
                                minHeight: 6.h,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildCashflowCard(CashflowSummary? cashflow) {
    if (cashflow == null) {
      return const SizedBox.shrink();
    }

    final netColor = cashflow.netCashflow >= 0 ? Colors.greenAccent : Colors.redAccent;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildCashflowItem('Thu vào', cashflow.totalIncome, Colors.greenAccent, LucideIcons.trendingUp),
          SizedBox(width: 12.w),
          _buildCashflowItem('Chi ra', cashflow.totalExpense, Colors.redAccent, LucideIcons.trendingDown),
          SizedBox(width: 12.w),
          _buildCashflowItem('Net', cashflow.netCashflow, netColor, LucideIcons.calculator),
        ],
      ),
    );
  }

  Widget _buildCashflowItem(String label, double amount, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 10.h),
            Text(label, style: TextStyle(color: AppColors.text, fontSize: 13.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 6.h),
            Text(
              _abbrev(amount),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 16.sp,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(List<ExpenseEntry> entries) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: entries.isEmpty
          ? Padding(
              padding: EdgeInsets.all(24.w),
              child: Center(
                child: Text(
                  'Chưa có giao dịch',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15.sp),
                ),
              ),
            )
          : Column(
              children: entries.map((entry) {
                final isIncome = entry.transactionType == TransactionType.income;
                final sign = isIncome ? '+' : '-';
                final color = isIncome ? Colors.greenAccent : AppColors.primary;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.network(
                          entry.thumbnailUrl,
                          width: 54.w,
                          height: 54.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 54.w,
                            height: 54.w,
                            color: AppColors.text.withOpacity(0.1),
                            child: Icon(LucideIcons.image, size: 24.sp, color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.categoryName ?? 'Khác',
                              style: TextStyle(
                                color: AppColors.text,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              DateFormat('dd/MM HH:mm').format(entry.takenAt),
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '$sign${_currencyFormat.format(entry.amount)}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Future<void> _onEditBudget() async {
    final currentLimit = ref.read(expenseCurrentBudgetProvider)?.amountLimit;
    final limit = await BudgetInputBottomSheet.show(
      context,
      currentLimit: currentLimit,
    );
    if (limit == null || !mounted) return;

    ref
        .read(expenseProvider.notifier)
        .updateBudget(_currentMonthKey, limit, 80);
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, bottom: 16.h),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconLabel({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.text.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.text, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
// End of file
