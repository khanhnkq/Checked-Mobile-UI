import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../expense/presentation/providers/expense_provider.dart';
import '../../../expense/presentation/screens/expense_screen.dart';
import '../../../expense/data/models/expense_models.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _monthKey;

  @override
  void initState() {
    super.initState();
    _monthKey = DateFormat('yyyyMM').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().fetchMonthlyData(_monthKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.userProfile;
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
          child: const Text(
            'Locket GOLD',
            style: TextStyle(
              color: Color(0xFFFFD35A),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.users, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.settings, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronRight, color: Colors.white, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName.isNotEmpty ? displayName : 'Người dùng Locket',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '@$username',
                              style: const TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(width: 4),
                            const Icon(LucideIcons.link, color: Colors.grey, size: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFFD35A), width: 3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: user?.avatarUrl != null 
                            ? NetworkImage(user!.avatarUrl!) 
                            : null,
                        child: user?.avatarUrl == null 
                            ? const Icon(LucideIcons.user, size: 30) 
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
            const Icon(LucideIcons.send, color: Colors.grey, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Gửi locket đầu tiên của bạn !',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('⁞', style: TextStyle(color: Colors.grey, fontSize: 24)),
            
            const SizedBox(height: 10),
            _buildExpenseCalendarWidget(context),
            const SizedBox(height: 10),
            const Text('⁞', style: TextStyle(color: Colors.grey, fontSize: 24)),

            const SizedBox(height: 24),
            // Footer info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.heart, color: Color(0xFFFFD35A), size: 16),
                  Text(' 2 Locket | ', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  Icon(LucideIcons.flame, color: Colors.orange, size: 16),
                  Text(' 2d chuỗi', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCalendarWidget(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        final summary = provider.currentSummary;
        final entries = provider.entries;
        
        final Map<int, ExpenseEntry> entryMap = {};
        for (var entry in entries) {
          entryMap[entry.takenAt.day] = entry;
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExpenseScreen()),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2B26),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A4944),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Text(
                    DateFormat('MMMM yyyy', 'vi_VN').format(DateTime.now()).toLowerCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (summary != null) ...[
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: (summary.percentUsed / 100).clamp(0.0, 1.0),
                                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                                  color: summary.budgetExceeded ? Colors.redAccent : const Color(0xFFFFD35A),
                                  minHeight: 6,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${summary.percentUsed.toStringAsFixed(0)}%',
                              style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                      
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: 28,
                        itemBuilder: (context, index) {
                          final dayNum = index + 1;
                          final entry = entryMap[dayNum];
                          
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8),
                              image: entry != null ? DecorationImage(
                                image: NetworkImage(entry.thumbnailUrl),
                                fit: BoxFit.cover,
                              ) : null,
                              border: entry != null ? Border.all(color: const Color(0xFFFFD35A), width: 1.5) : null,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
