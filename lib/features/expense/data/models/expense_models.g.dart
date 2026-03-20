// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseCategoryImpl _$$ExpenseCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$ExpenseCategoryImpl(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? 'Chưa rõ',
  icon: json['icon'] as String? ?? '',
  color: json['color'] as String? ?? '#FFFFFF',
  isDefault: json['isDefault'] as bool? ?? false,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$$ExpenseCategoryImplToJson(
  _$ExpenseCategoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'color': instance.color,
  'isDefault': instance.isDefault,
  'isActive': instance.isActive,
};

_$MonthlyBudgetImpl _$$MonthlyBudgetImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyBudgetImpl(
      monthKey: json['monthKey'] as String? ?? '',
      amountLimit: _toNullableDouble(json['amountLimit']),
      alertThresholdPct: (json['alertThresholdPct'] as num?)?.toInt(),
      spent: _toDoubleOrZero(json['spent']),
      remaining: _toNullableDouble(json['remaining']),
      exceeded: json['exceeded'] as bool? ?? false,
    );

Map<String, dynamic> _$$MonthlyBudgetImplToJson(_$MonthlyBudgetImpl instance) =>
    <String, dynamic>{
      'monthKey': instance.monthKey,
      'amountLimit': instance.amountLimit,
      'alertThresholdPct': instance.alertThresholdPct,
      'spent': instance.spent,
      'remaining': instance.remaining,
      'exceeded': instance.exceeded,
    };

_$ExpenseSummaryImpl _$$ExpenseSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseSummaryImpl(
      monthKey: json['monthKey'] as String? ?? '',
      totalSpent: _toDoubleOrZero(json['totalSpent']),
      budgetLimit: _toNullableDouble(json['budgetLimit']),
      remaining: _toNullableDouble(json['remaining']),
      budgetExceeded: json['budgetExceeded'] as bool? ?? false,
      percentUsed: _toDoubleOrZero(json['percentUsed']),
      byCategory:
          (json['byCategory'] as List<dynamic>?)
              ?.map((e) => CategorySummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$ExpenseSummaryImplToJson(
  _$ExpenseSummaryImpl instance,
) => <String, dynamic>{
  'monthKey': instance.monthKey,
  'totalSpent': instance.totalSpent,
  'budgetLimit': instance.budgetLimit,
  'remaining': instance.remaining,
  'budgetExceeded': instance.budgetExceeded,
  'percentUsed': instance.percentUsed,
  'byCategory': instance.byCategory,
};

_$CategorySummaryImpl _$$CategorySummaryImplFromJson(
  Map<String, dynamic> json,
) => _$CategorySummaryImpl(
  categoryId: json['categoryId'] as String? ?? '',
  categoryName: json['categoryName'] as String? ?? 'Chưa rõ',
  totalAmount: _toDoubleOrZero(json['totalAmount']),
);

Map<String, dynamic> _$$CategorySummaryImplToJson(
  _$CategorySummaryImpl instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'totalAmount': instance.totalAmount,
};

_$ExpenseEntryImpl _$$ExpenseEntryImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseEntryImpl(
      photoId: json['photoId'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      amount: _toDoubleOrZero(json['amount']),
      note: json['note'] as String?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      takenAt: _dateTimeOrNowFromJson(json['takenAt']),
      createdAt: _dateTimeOrNowFromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ExpenseEntryImplToJson(_$ExpenseEntryImpl instance) =>
    <String, dynamic>{
      'photoId': instance.photoId,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'amount': instance.amount,
      'note': instance.note,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'takenAt': instance.takenAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
