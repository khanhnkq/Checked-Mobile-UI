import 'package:equatable/equatable.dart';

import '../../data/models/expense_models.dart';
import '../repositories/expense_repository.dart';

class ExpenseMonthlyDataResult extends Equatable {
  const ExpenseMonthlyDataResult({
    required this.summary,
    required this.budget,
    required this.entries,
  });

  final ExpenseSummary summary;
  final MonthlyBudget budget;
  final List<ExpenseEntry> entries;

  @override
  List<Object?> get props => [summary, budget, entries];
}

class FetchExpenseMonthlyDataUseCase {
  const FetchExpenseMonthlyDataUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<ExpenseMonthlyDataResult> call(String monthKey) async {
    final results = await Future.wait([
      _repository.getSummary(monthKey),
      _repository.getBudget(monthKey),
      _repository.getEntries(monthKey),
    ]);

    return ExpenseMonthlyDataResult(
      summary: results[0] as ExpenseSummary,
      budget: results[1] as MonthlyBudget,
      entries: results[2] as List<ExpenseEntry>,
    );
  }
}

