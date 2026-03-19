import 'package:flutter/material.dart';

import '../../data/models/expense_models.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/usecases/fetch_expense_categories_usecase.dart';
import '../../domain/usecases/fetch_expense_monthly_data_usecase.dart';
import '../../domain/usecases/update_expense_budget_usecase.dart';
import '../../domain/usecases/update_photo_expense_usecase.dart';

class ExpenseViewModel extends ChangeNotifier {
  ExpenseViewModel({ExpenseRepository? repository})
      : _repository = repository ?? ExpenseRepositoryImpl() {
    _fetchExpenseCategoriesUseCase = FetchExpenseCategoriesUseCase(_repository);
    _fetchExpenseMonthlyDataUseCase = FetchExpenseMonthlyDataUseCase(_repository);
    _updateExpenseBudgetUseCase = UpdateExpenseBudgetUseCase(_repository);
    _updatePhotoExpenseUseCase = UpdatePhotoExpenseUseCase(_repository);
  }

  final ExpenseRepository _repository;
  late final FetchExpenseCategoriesUseCase _fetchExpenseCategoriesUseCase;
  late final FetchExpenseMonthlyDataUseCase _fetchExpenseMonthlyDataUseCase;
  late final UpdateExpenseBudgetUseCase _updateExpenseBudgetUseCase;
  late final UpdatePhotoExpenseUseCase _updatePhotoExpenseUseCase;

  List<ExpenseCategory> _categories = [];
  ExpenseSummary? _currentSummary;
  MonthlyBudget? _currentBudget;
  List<ExpenseEntry> _entries = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ExpenseCategory> get categories => _categories;
  ExpenseSummary? get currentSummary => _currentSummary;
  MonthlyBudget? get currentBudget => _currentBudget;
  List<ExpenseEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _fetchExpenseCategoriesUseCase.call();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMonthlyData(String monthKey) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _fetchExpenseMonthlyDataUseCase.call(monthKey);
      _currentSummary = result.summary;
      _currentBudget = result.budget;
      _entries = result.entries;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBudget(
    String monthKey,
    double limit,
    int threshold,
  ) async {
    try {
      _currentBudget = await _updateExpenseBudgetUseCase.call(
        monthKey,
        limit,
        threshold,
      );
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
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
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}

