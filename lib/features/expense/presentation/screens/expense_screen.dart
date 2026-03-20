import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:locket/features/expense/data/models/expense_models.dart';
import 'package:locket/features/expense/presentation/riverpod_providers.dart';

class ExpenseScreen extends ConsumerStatefulWidget {
  const ExpenseScreen({super.key});

  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  late String _currentMonthKey;
  final _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0);

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

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Chi tiêu tháng này', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: () {
        if (expenseState.isLoading && expenseState.currentSummary == null) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFFD35A)),
          );
        }

        final summary = expenseState.currentSummary;
        if (summary == null) return const SizedBox.shrink();

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(expenseProvider.notifier).fetchMonthlyData(_currentMonthKey),
          color: const Color(0xFFFFD35A),
          backgroundColor: const Color(0xFF2C2B26),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildOverviewCard(summary),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Hạng mục chi tiêu'),
                _buildCategoryCard(summary),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Lịch sử giao dịch'),
                _buildTransactionList(expenseState.entries),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }(),
    );
  }

  Widget _buildOverviewCard(ExpenseSummary summary) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF2C2B26), borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconLabel(icon: LucideIcons.wallet, label: 'Tổng đã chi'),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(LucideIcons.settings2, color: Colors.grey, size: 18),
                onPressed: () => _showUpdateBudgetDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(_currencyFormat.format(summary.totalSpent), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFFFD35A))),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (summary.percentUsed / 100).clamp(0.0, 1.0),
              backgroundColor: Colors.white.withOpacity(0.05),
              color: summary.budgetExceeded ? Colors.redAccent : const Color(0xFFFFD35A),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tiến độ: ${summary.percentUsed.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey, fontSize: 13)),
              if (summary.remaining != null)
                Text(
                  summary.remaining! >= 0 ? 'Còn lại: ${_currencyFormat.format(summary.remaining)}' : 'Vượt: ${_currencyFormat.format(summary.remaining!.abs())}',
                  style: TextStyle(color: summary.remaining! >= 0 ? Colors.greenAccent : Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(ExpenseSummary summary) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF2C2B26), borderRadius: BorderRadius.circular(24)),
      child: summary.byCategory.isEmpty 
        ? const Padding(padding: EdgeInsets.all(20), child: Center(child: Text('Chưa có dữ liệu', style: TextStyle(color: Colors.grey))))
        : Column(
            children: summary.byCategory.map((cat) => ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                child: const Icon(LucideIcons.tag, color: Colors.white, size: 16),
              ),
              title: Text(cat.categoryName, style: const TextStyle(color: Colors.white, fontSize: 14)),
              trailing: Text(_currencyFormat.format(cat.totalAmount), style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            )).toList(),
          ),
    );
  }

  Widget _buildTransactionList(List<ExpenseEntry> entries) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF2C2B26), borderRadius: BorderRadius.circular(24)),
      child: entries.isEmpty
        ? const Padding(padding: EdgeInsets.all(20), child: Center(child: Text('Chưa có giao dịch', style: TextStyle(color: Colors.grey))))
        : Column(
            children: entries.map((entry) => ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(entry.thumbnailUrl, width: 44, height: 44, fit: BoxFit.cover, 
                  errorBuilder: (_, __, ___) => Container(width: 44, height: 44, color: Colors.white10, child: const Icon(LucideIcons.image, size: 20))),
              ),
              title: Text(entry.categoryName ?? 'Khác', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Text(DateFormat('dd/MM HH:mm').format(entry.takenAt), style: const TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: Text(_currencyFormat.format(entry.amount), style: const TextStyle(color: Color(0xFFFFD35A), fontWeight: FontWeight.bold)),
            )).toList(),
          ),
    );
  }

  void _showUpdateBudgetDialog(BuildContext context) {
    final currentBudget = ref.read(expenseCurrentBudgetProvider);
    final controller = TextEditingController(
      text: currentBudget?.amountLimit?.toInt().toString() ?? '',
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2B26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Hạn mức chi tiêu', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(suffixText: '₫', suffixStyle: TextStyle(color: Color(0xFFFFD35A))),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              final limit = double.tryParse(controller.text);
              if (limit != null) {
                ref.read(expenseProvider.notifier).updateBudget(
                      _currentMonthKey,
                      limit,
                      80,
                    );
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

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 20, bottom: 12), child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)));
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
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }
}
