import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_locator.dart';
import 'riverpod_notifiers/expense_notifier.dart';
import 'riverpod_notifiers/expense_state.dart';

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, ExpenseState>((ref) {
  return ExpenseNotifier(
    repository: ref.watch(expenseRepositoryProvider),
  );
});

// Selector providers for easier consumption
final expenseCategoriesProvider = Provider((ref) {
  return ref.watch(expenseProvider).categories;
});

final expenseCurrentSummaryProvider = Provider((ref) {
  return ref.watch(expenseProvider).currentSummary;
});

final expenseCurrentBudgetProvider = Provider((ref) {
  return ref.watch(expenseProvider).currentBudget;
});

final expenseEntriesProvider = Provider((ref) {
  return ref.watch(expenseProvider).entries;
});

final expenseIsLoadingProvider = Provider((ref) {
  return ref.watch(expenseProvider).isLoading;
});

final expenseErrorMessageProvider = Provider((ref) {
  return ref.watch(expenseProvider).errorMessage;
});

