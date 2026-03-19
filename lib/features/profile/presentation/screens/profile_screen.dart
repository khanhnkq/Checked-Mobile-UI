import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/riverpod_providers.dart';
import '../../../expense/presentation/riverpod_providers.dart';
import '../../../expense/data/models/expense_models.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late String _monthKey;
  final _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _monthKey = DateFormat('yyyyMM').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expenseProvider.notifier).fetchMonthlyData(_monthKey);
    });
  }

  void _showUpdateBudgetDialog(BuildContext context) {
    final currentBudget = ref.read(expenseProvider).currentBudget;
    final controller = TextEditingController(
      text: currentBudget?.amountLimit?.toInt().toString() ?? ''
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2B26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Hạn mức chi tiêu', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hạn mức cho tháng này', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                suffixText: '₫',
                suffixStyle: const TextStyle(color: Color(0xFFFFD35A)),
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final limit = double.tryParse(controller.text);
              if (limit != null) {
                ref.read(expenseProvider.notifier).updateBudget(_monthKey, limit, 80);
                context.pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD35A),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Lưu lại', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProfileProvider);
    final displayName = '${user?.firstName ?? ""} ${user?.lastName ?? ""}'.trim();
    final username = user?.username ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFF12110B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFD35A)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text('Locket GOLD', style: TextStyle(color: Color(0xFFFFD35A), fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        actions: [
          IconButton(icon: const Icon(LucideIcons.users, color: Colors.white), onPressed: () {}),
          IconButton(
            icon: const Icon(LucideIcons.settings, color: Colors.white),
            onPressed: () => context.push('/settings'),
          ),
          IconButton(icon: const Icon(LucideIcons.chevronRight, color: Colors.white, size: 24), onPressed: () => context.pop()),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(displayName, username, user?.avatarUrl),
            const SizedBox(height: 32),
            
            const _SectionTitle(title: 'Ngân sách'),
            _buildBudgetCard(context),
            
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Lịch sử chi tiêu'),
            _buildCalendarCard(context),

            const SizedBox(height: 32),
            Center(child: _buildStatsFooter()),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(String name, String username, String? avatarUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFFFD35A), width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: avatarUrl == null ? const Icon(LucideIcons.user, size: 24) : null,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.isNotEmpty ? name : 'Người dùng Locket', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('@$username', style: const TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context) {
    final summary = ref.watch(expenseCurrentSummaryProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF2C2B26), borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconLabel(icon: LucideIcons.wallet, label: 'Đã chi tiêu'),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(LucideIcons.edit3, color: Colors.grey, size: 18),
                onPressed: () => _showUpdateBudgetDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(summary != null ? _currencyFormat.format(summary.totalSpent) : '0₫', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              if (summary?.budgetLimit != null) ...[
                const SizedBox(width: 8),
                Text('/ ${_currencyFormat.format(summary!.budgetLimit)}', style: const TextStyle(color: Colors.white38, fontSize: 14)),
              ],
            ],
          ),
          if (summary != null) ...[
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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tiến độ: ${summary.percentUsed.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                if (summary.remaining != null)
                      Text(
                        summary.remaining! >= 0 ? 'Còn lại: ${_currencyFormat.format(summary.remaining)}' : 'Vượt: ${_currencyFormat.format(summary.remaining!.abs())}',
                        style: TextStyle(color: summary.remaining! >= 0 ? Colors.greenAccent : Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ],
            ],
          ),
        );
  }

  Widget _buildCalendarCard(BuildContext context) {
    final entries = ref.watch(expenseEntriesProvider);
    final Map<int, ExpenseEntry> entryMap = {};
    for (var entry in entries) { entryMap[entry.takenAt.day] = entry; }

    return GestureDetector(
      onTap: () => context.push('/expense'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: const Color(0xFF2C2B26), borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _IconLabel(icon: LucideIcons.calendar, label: DateFormat('MMMM yyyy', 'vi_VN').format(DateTime.now())),
                      const Icon(LucideIcons.chevronRight, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: GridView.builder(
                    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 8, crossAxisSpacing: 8),
                    itemCount: 28,
                    itemBuilder: (context, index) {
                      final dayNum = index + 1;
                      final entry = entryMap[dayNum];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(8),
                          image: entry != null ? DecorationImage(image: NetworkImage(entry.thumbnailUrl), fit: BoxFit.cover) : null,
                          border: entry != null ? Border.all(color: const Color(0xFFFFD35A), width: 1.5) : null,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildStatsFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(25)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.heart, color: Color(0xFFFFD35A), size: 16),
          Text(' 2 Locket | ', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          Icon(LucideIcons.flame, color: Colors.orange, size: 16),
          Text(' 2d chuỗi', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
