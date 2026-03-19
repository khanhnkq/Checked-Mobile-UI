import '../../data/models/expense_models.dart';
import '../repositories/expense_repository.dart';

class UpdateExpenseBudgetUseCase {
  const UpdateExpenseBudgetUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<MonthlyBudget> call(
    String monthKey,
    double amountLimit,
    int alertThresholdPct,
  ) {
    return _repository.updateBudget(monthKey, amountLimit, alertThresholdPct);
  }
}

