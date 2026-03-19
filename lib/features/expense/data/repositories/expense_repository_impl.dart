import '../../domain/repositories/expense_repository.dart';
import '../models/expense_models.dart';
import '../services/expense_service.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  ExpenseRepositoryImpl({ExpenseService? expenseService})
      : _expenseService = expenseService ?? ExpenseService();

  final ExpenseService _expenseService;

  @override
  Future<List<ExpenseCategory>> getCategories() {
    return _expenseService.getCategories();
  }

  @override
  Future<ExpenseSummary> getSummary(String monthKey) {
    return _expenseService.getSummary(monthKey);
  }

  @override
  Future<MonthlyBudget> getBudget(String monthKey) {
    return _expenseService.getBudget(monthKey);
  }

  @override
  Future<List<ExpenseEntry>> getEntries(String monthKey) {
    return _expenseService.getEntries(monthKey);
  }

  @override
  Future<MonthlyBudget> updateBudget(
    String monthKey,
    double amountLimit,
    int alertThresholdPct,
  ) {
    return _expenseService.updateBudget(monthKey, amountLimit, alertThresholdPct);
  }

  @override
  Future<void> updatePhotoExpense(
    String photoId, {
    double? amount,
    String? note,
    String? categoryId,
  }) {
    return _expenseService.updatePhotoExpense(
      photoId,
      amount: amount,
      note: note,
      categoryId: categoryId,
    );
  }
}

