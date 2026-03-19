import '../repositories/expense_repository.dart';

class UpdatePhotoExpenseUseCase {
  const UpdatePhotoExpenseUseCase(this._repository);

  final ExpenseRepository _repository;

  Future<void> call(
    String photoId, {
    double? amount,
    String? note,
    String? categoryId,
  }) {
    return _repository.updatePhotoExpense(
      photoId,
      amount: amount,
      note: note,
      categoryId: categoryId,
    );
  }
}

