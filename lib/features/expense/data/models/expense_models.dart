// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_models.freezed.dart';
part 'expense_models.g.dart';

double _toDoubleOrZero(Object? value) => (value as num?)?.toDouble() ?? 0;
double? _toNullableDouble(Object? value) => (value as num?)?.toDouble();
DateTime _dateTimeOrNowFromJson(Object? value) {
  if (value is String && value.isNotEmpty) {
    return DateTime.parse(value);
  }
  return DateTime.now();
}

@freezed
class ExpenseCategory with _$ExpenseCategory {
  const factory ExpenseCategory({
    @JsonKey(defaultValue: '') required String id,
    @JsonKey(defaultValue: 'Chưa rõ') required String name,
    @JsonKey(defaultValue: '') required String icon,
    @JsonKey(defaultValue: '#FFFFFF') required String color,
    @JsonKey(defaultValue: false) required bool isDefault,
    @JsonKey(defaultValue: true) required bool isActive,
  }) = _ExpenseCategory;

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryFromJson(json);
}

@freezed
class MonthlyBudget with _$MonthlyBudget {
  const factory MonthlyBudget({
    @JsonKey(defaultValue: '') required String monthKey,
    @JsonKey(fromJson: _toNullableDouble) double? amountLimit,
    int? alertThresholdPct,
    @JsonKey(fromJson: _toDoubleOrZero) required double spent,
    @JsonKey(fromJson: _toNullableDouble) double? remaining,
    @JsonKey(defaultValue: false) required bool exceeded,
  }) = _MonthlyBudget;

  factory MonthlyBudget.fromJson(Map<String, dynamic> json) =>
      _$MonthlyBudgetFromJson(json);
}

@freezed
class ExpenseSummary with _$ExpenseSummary {
  const factory ExpenseSummary({
    @JsonKey(defaultValue: '') required String monthKey,
    @JsonKey(fromJson: _toDoubleOrZero) required double totalSpent,
    @JsonKey(fromJson: _toNullableDouble) double? budgetLimit,
    @JsonKey(fromJson: _toNullableDouble) double? remaining,
    @JsonKey(defaultValue: false) required bool budgetExceeded,
    @JsonKey(fromJson: _toDoubleOrZero) required double percentUsed,
    @JsonKey(defaultValue: <CategorySummary>[]) required List<CategorySummary> byCategory,
  }) = _ExpenseSummary;

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSummaryFromJson(json);
}

@freezed
class CategorySummary with _$CategorySummary {
  const factory CategorySummary({
    @JsonKey(defaultValue: '') required String categoryId,
    @JsonKey(defaultValue: 'Chưa rõ') required String categoryName,
    @JsonKey(fromJson: _toDoubleOrZero) required double totalAmount,
  }) = _CategorySummary;

  factory CategorySummary.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryFromJson(json);
}

@freezed
class ExpenseEntry with _$ExpenseEntry {
  const factory ExpenseEntry({
    @JsonKey(defaultValue: '') required String photoId,
    @JsonKey(defaultValue: '') required String imageUrl,
    @JsonKey(defaultValue: '') required String thumbnailUrl,
    @JsonKey(fromJson: _toDoubleOrZero) required double amount,
    String? note,
    String? categoryId,
    String? categoryName,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) required DateTime takenAt,
    @JsonKey(fromJson: _dateTimeOrNowFromJson) required DateTime createdAt,
  }) = _ExpenseEntry;

  factory ExpenseEntry.fromJson(Map<String, dynamic> json) =>
      _$ExpenseEntryFromJson(json);
}
