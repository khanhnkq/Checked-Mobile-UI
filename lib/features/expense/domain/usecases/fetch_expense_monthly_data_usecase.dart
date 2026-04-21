import 'package:equatable/equatable.dart';

import '../../data/models/expense_models.dart';
import '../repositories/expense_repository.dart';

class ExpenseMonthlyDataResult extends Equatable {
  const ExpenseMonthlyDataResult({
    required this.summary,
    required this.budget,
    required this.cashflow,
    required this.entries,
  });

  final ExpenseSummary summary;
  final MonthlyBudget budget;
  final CashflowSummary cashflow;
  final List<ExpenseEntry> entries;

  @override
  List<Object?> get props => [summary, budget, cashflow, entries];
}

class FetchExpenseMonthlyDataUseCase {
  const FetchExpenseMonthlyDataUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<ExpenseMonthlyDataResult> call(String monthKey) async {
    final results = await Future.wait([
      _repository.getSummary(monthKey),
      _repository.getBudget(monthKey),
      _repository.getCashflow(monthKey),
      _repository.getEntries(monthKey, type: TransactionType.expense),
    ]);

    return ExpenseMonthlyDataResult(
      summary: results[0] as ExpenseSummary,
      budget: results[1] as MonthlyBudget,
      cashflow: results[2] as CashflowSummary,
      entries: results[3] as List<ExpenseEntry>,
    );
  }
}

