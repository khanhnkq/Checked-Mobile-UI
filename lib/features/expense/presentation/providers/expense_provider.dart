import 'package:flutter/material.dart';
import '../../data/models/expense_models.dart';
import '../../data/services/expense_service.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();

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
      _categories = await _expenseService.getCategories();
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
      final results = await Future.wait([
        _expenseService.getSummary(monthKey),
        _expenseService.getBudget(monthKey),
        _expenseService.getEntries(monthKey),
      ]);
      _currentSummary = results[0] as ExpenseSummary;
      _currentBudget = results[1] as MonthlyBudget;
      _entries = results[2] as List<ExpenseEntry>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBudget(String monthKey, double limit, int threshold) async {
    try {
      _currentBudget = await _expenseService.updateBudget(monthKey, limit, threshold);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updatePhotoExpense(String photoId, {double? amount, String? note, String? categoryId}) async {
    try {
      await _expenseService.updatePhotoExpense(photoId, amount: amount, note: note, categoryId: categoryId);
      // Optional: Refresh data if needed
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
