import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/expense_models.dart';

part 'expense_state.freezed.dart';

@freezed
class ExpenseState with _$ExpenseState {
  const factory ExpenseState({
    @Default([]) List<ExpenseCategory> categories,
    ExpenseSummary? currentSummary,
    MonthlyBudget? currentBudget,
    @Default([]) List<ExpenseEntry> entries,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ExpenseState;

  factory ExpenseState.initial() => const ExpenseState();
}

