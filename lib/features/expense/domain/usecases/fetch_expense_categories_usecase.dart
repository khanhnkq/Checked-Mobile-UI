import '../../data/models/expense_models.dart';
import '../repositories/expense_repository.dart';

class FetchExpenseCategoriesUseCase {
  const FetchExpenseCategoriesUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<List<ExpenseCategory>> call() {
    return _repository.getCategories();
  }
}

