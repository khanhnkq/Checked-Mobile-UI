class ExpenseCategory {
  final String id;
  final String name;
  final String icon;
  final String color;
  final bool isDefault;
  final bool isActive;

  ExpenseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isDefault,
    required this.isActive,
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) => ExpenseCategory(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? 'Chưa rõ',
        icon: json['icon'] as String? ?? '',
        color: json['color'] as String? ?? '#FFFFFF',
        isDefault: json['isDefault'] as bool? ?? false,
        isActive: json['isActive'] as bool? ?? true,
      );
}

class MonthlyBudget {
  final String monthKey;
  final double? amountLimit;
  final int? alertThresholdPct;
  final double spent;
  final double? remaining;
  final bool exceeded;

  MonthlyBudget({
    required this.monthKey,
    this.amountLimit,
    this.alertThresholdPct,
    required this.spent,
    this.remaining,
    required this.exceeded,
  });

  factory MonthlyBudget.fromJson(Map<String, dynamic> json) => MonthlyBudget(
        monthKey: json['monthKey'] as String? ?? '',
        amountLimit: (json['amountLimit'] as num?)?.toDouble(),
        alertThresholdPct: json['alertThresholdPct'] as int?,
        spent: (json['spent'] as num? ?? 0).toDouble(),
        remaining: (json['remaining'] as num?)?.toDouble(),
        exceeded: json['exceeded'] as bool? ?? false,
      );
}

class ExpenseSummary {
  final String monthKey;
  final double totalSpent;
  final double? budgetLimit;
  final double? remaining;
  final bool budgetExceeded;
  final double percentUsed;
  final List<CategorySummary> byCategory;

  ExpenseSummary({
    required this.monthKey,
    required this.totalSpent,
    this.budgetLimit,
    this.remaining,
    required this.budgetExceeded,
    required this.percentUsed,
    required this.byCategory,
  });

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) => ExpenseSummary(
        monthKey: json['monthKey'] as String? ?? '',
        totalSpent: (json['totalSpent'] as num? ?? 0).toDouble(),
        budgetLimit: (json['budgetLimit'] as num?)?.toDouble(),
        remaining: (json['remaining'] as num?)?.toDouble(),
        budgetExceeded: json['budgetExceeded'] as bool? ?? false,
        percentUsed: (json['percentUsed'] as num? ?? 0).toDouble(),
        byCategory: (json['byCategory'] as List<dynamic>?)
                ?.map((e) => CategorySummary.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class CategorySummary {
  final String categoryId;
  final String categoryName;
  final double totalAmount;

  CategorySummary({
    required this.categoryId,
    required this.categoryName,
    required this.totalAmount,
  });

  factory CategorySummary.fromJson(Map<String, dynamic> json) => CategorySummary(
        categoryId: json['categoryId'] as String? ?? '',
        categoryName: json['categoryName'] as String? ?? 'Chưa rõ',
        totalAmount: (json['totalAmount'] as num? ?? 0).toDouble(),
      );
}

class ExpenseEntry {
  final String photoId;
  final String imageUrl;
  final String thumbnailUrl;
  final double amount;
  final String? note;
  final String? categoryId;
  final String? categoryName;
  final DateTime takenAt;
  final DateTime createdAt;

  ExpenseEntry({
    required this.photoId,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.amount,
    this.note,
    this.categoryId,
    this.categoryName,
    required this.takenAt,
    required this.createdAt,
  });

  factory ExpenseEntry.fromJson(Map<String, dynamic> json) => ExpenseEntry(
        photoId: json['photoId'] as String? ?? '',
        imageUrl: json['imageUrl'] as String? ?? '',
        thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
        amount: (json['amount'] as num? ?? 0).toDouble(),
        note: json['note'] as String?,
        categoryId: json['categoryId'] as String?,
        categoryName: json['categoryName'] as String?,
        takenAt: json['takenAt'] != null ? DateTime.parse(json['takenAt'] as String) : DateTime.now(),
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
      );
}
