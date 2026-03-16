import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:locket/features/expense/presentation/providers/expense_provider.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late String _currentMonthKey;

  @override
  void initState() {
    super.initState();
    _currentMonthKey = DateFormat('yyyyMM').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().fetchMonthlyData(_currentMonthKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Chi tiêu', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.currentSummary == null) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFD35A)));
          }

          if (provider.errorMessage != null && provider.currentSummary == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage!, style: const TextStyle(color: Colors.white70)),
                  TextButton(
                    onPressed: () => provider.fetchMonthlyData(_currentMonthKey),
                    child: const Text('Thử lại', style: TextStyle(color: Color(0xFFFFD35A))),
                  ),
                ],
              ),
            );
          }

          final summary = provider.currentSummary;
          if (summary == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: () => provider.fetchMonthlyData(_currentMonthKey),
            color: const Color(0xFFFFD35A),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBudgetCard(provider),
                  const SizedBox(height: 24),
                  const Text(
                    'Phân bổ theo hạng mục',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryBreakdown(summary),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Lịch sử chi tiêu',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        '${provider.entries.length} giao dịch',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildExpenseEntries(provider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBudgetCard(ExpenseProvider provider) {
    final summary = provider.currentSummary!;
    final budget = provider.currentBudget;
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1D17),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng chi tiêu tháng này', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD35A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  DateFormat('MM/yyyy').format(DateTime.now()),
                  style: const TextStyle(color: Color(0xFFFFD35A), fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormat.format(summary.totalSpent),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          if (budget?.amountLimit != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ngân sách: ${currencyFormat.format(budget!.amountLimit)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Text(
                  '${summary.percentUsed.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: summary.budgetExceeded ? Colors.redAccent : const Color(0xFFFFD35A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (summary.percentUsed / 100).clamp(0.0, 1.0),
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                color: summary.budgetExceeded ? Colors.redAccent : const Color(0xFFFFD35A),
                minHeight: 8,
              ),
            ),
            if (summary.remaining != null && summary.remaining! > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Còn lại: ${currencyFormat.format(summary.remaining)}',
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 12),
                ),
              )
            else if (summary.budgetExceeded)
              const Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Đã vượt ngân sách!',
                  style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
          ] else
            TextButton.icon(
              onPressed: () => _showUpdateBudgetDialog(context, provider),
              icon: const Icon(LucideIcons.plus, size: 16, color: Color(0xFFFFD35A)),
              label: const Text('Thiết lập ngân sách', style: TextStyle(color: Color(0xFFFFD35A))),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown(ExpenseSummary summary) {
    if (summary.byCategory.isEmpty) {
      return const Center(child: Text('Chưa có phân loại nào', style: TextStyle(color: Colors.grey)));
    }

    return Column(
      children: summary.byCategory.map((cat) {
        final percentage = summary.totalSpent > 0 ? (cat.totalAmount / summary.totalSpent) * 100 : 0.0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(LucideIcons.tag, size: 18, color: Colors.white70),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cat.categoryName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(cat.totalAmount),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: (percentage / 100).clamp(0.0, 1.0),
                              backgroundColor: Colors.white.withValues(alpha: 0.05),
                              color: const Color(0xFFFFD35A),
                              minHeight: 4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExpenseEntries(ExpenseProvider provider) {
    if (provider.entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text('Chưa có giao dịch nào trong tháng này', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final entry = provider.entries[index];
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                entry.thumbnailUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.categoryName ?? 'Chưa phân loại',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  if (entry.note != null && entry.note!.isNotEmpty)
                    Text(
                      entry.note!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  Text(
                    DateFormat('dd/MM HH:mm').format(entry.takenAt),
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ],
              ),
            ),
            Text(
              NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(entry.amount),
              style: const TextStyle(color: Color(0xFFFFD35A), fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateBudgetDialog(BuildContext context, ExpenseProvider provider) {
    final controller = TextEditingController(text: provider.currentBudget?.amountLimit?.toInt().toString() ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1D17),
        title: const Text('Thiết lập ngân sách'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Nhập số tiền (₫)',
            hintStyle: TextStyle(color: Colors.white38),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD35A))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              final limit = double.tryParse(controller.text);
              if (limit != null) {
                provider.updateBudget(_currentMonthKey, limit, 80);
                Navigator.pop(context);
              }
            },
            child: const Text('Lưu', style: TextStyle(color: Color(0xFFFFD35A))),
          ),
        ],
      ),
    );
  }
}
