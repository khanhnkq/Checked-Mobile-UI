import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/expense_models.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/usecases/fetch_expense_categories_usecase.dart';
import '../../domain/usecases/fetch_expense_monthly_data_usecase.dart';
import '../../domain/usecases/update_expense_budget_usecase.dart';
import '../../domain/usecases/update_photo_expense_usecase.dart';
import 'expense_state.dart';

class ExpenseNotifier extends StateNotifier<ExpenseState> {
  final ExpenseRepository _repository;
  late final FetchExpenseCategoriesUseCase _fetchExpenseCategoriesUseCase;
  late final FetchExpenseMonthlyDataUseCase _fetchExpenseMonthlyDataUseCase;
  late final UpdateExpenseBudgetUseCase _updateExpenseBudgetUseCase;
  late final UpdatePhotoExpenseUseCase _updatePhotoExpenseUseCase;

  ExpenseNotifier({ExpenseRepository? repository})
      : _repository = repository ?? ExpenseRepositoryImpl(),
        super(ExpenseState.initial()) {
    _fetchExpenseCategoriesUseCase = FetchExpenseCategoriesUseCase(_repository);
    _fetchExpenseMonthlyDataUseCase = FetchExpenseMonthlyDataUseCase(_repository);
    _updateExpenseBudgetUseCase = UpdateExpenseBudgetUseCase(_repository);
    _updatePhotoExpenseUseCase = UpdatePhotoExpenseUseCase(_repository);
  }

  Future<void> fetchCategories() async {
    state = state.copyWith(isLoading: true);

    try {
      final categories = await _fetchExpenseCategoriesUseCase.call();
      state = state.copyWith(categories: categories);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchMonthlyData(
    String monthKey, {
    TransactionType? preferredType,
  }) async {
    final selectedType = preferredType ?? state.selectedType;
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final result = await _fetchExpenseMonthlyDataUseCase.call(
        monthKey,
        type: selectedType,
      );
      final entriesByType = <TransactionType, List<ExpenseEntry>>{
        ...state.entriesByType,
        selectedType: result.entries,
      };
      state = state.copyWith(
        currentSummary: result.summary,
        currentBudget: result.budget,
        currentCashflow: result.cashflow,
        entries: result.entries,
        entriesByType: entriesByType,
        selectedType: selectedType,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> selectType(
    String monthKey,
    TransactionType type,
  ) async {
    if (state.selectedType == type) return;

    final cached = state.entriesByType[type];
    if (cached != null) {
      state = state.copyWith(selectedType: type, entries: cached);
      return;
    }

    state = state.copyWith(
      isLoading: true,
      selectedType: type,
      errorMessage: null,
    );

    try {
      final fetchedEntries = await _repository.getEntries(monthKey, type: type);
      final updatedCache = <TransactionType, List<ExpenseEntry>>{
        ...state.entriesByType,
        type: fetchedEntries,
      };
      state = state.copyWith(
        entries: fetchedEntries,
        entriesByType: updatedCache,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> updateBudget(
    String monthKey,
    double limit,
    int threshold,
  ) async {
    state = state.copyWith(errorMessage: null);
    try {
      final updatedBudget = await _updateExpenseBudgetUseCase.call(
        monthKey,
        limit,
        threshold,
      );
      state = state.copyWith(currentBudget: updatedBudget);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<void> updatePhotoExpense(
    String photoId, {
    double? amount,
    String? note,
    String? categoryId,
  }) async {
    try {
      await _updatePhotoExpenseUseCase.call(
        photoId,
        amount: amount,
        note: note,
        categoryId: categoryId,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

