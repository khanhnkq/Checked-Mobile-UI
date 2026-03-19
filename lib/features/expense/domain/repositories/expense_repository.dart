import '../../data/models/expense_models.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseCategory>> getCategories();
  Future<ExpenseSummary> getSummary(String monthKey);
  Future<MonthlyBudget> getBudget(String monthKey);
  Future<List<ExpenseEntry>> getEntries(String monthKey);
  Future<MonthlyBudget> updateBudget(
    String monthKey,
    double amountLimit,
    int alertThresholdPct,
  );
  Future<void> updatePhotoExpense(
    String photoId, {
    double? amount,
    String? note,
    String? categoryId,
  });
}

