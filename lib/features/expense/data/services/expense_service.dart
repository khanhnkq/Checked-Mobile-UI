import 'package:dio/dio.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/network/dio_client.dart';
import '../models/expense_models.dart';

class ExpenseService {
  ExpenseService({Dio? dio}) : _dio = dio ?? DioClient().dio;

  final Dio _dio;

  Future<List<ExpenseCategory>> getCategories() async {
    try {
      final response = await _dio.get('/api/v1/expense/categories');
      final List<dynamic> data = response.data;
      return data.map((json) => ExpenseCategory.fromJson(json)).toList();
    } on DioException catch (e) {
      appLogger.e('GET CATEGORIES ERROR', error: e.response?.data ?? e);
      throw Exception('Không thể tải danh mục chi tiêu');
    } catch (e) {
      appLogger.e('GET CATEGORIES PARSE ERROR', error: e);
      throw Exception('Lỗi xử lý dữ liệu danh mục');
    }
  }

  Future<MonthlyBudget> getBudget(String monthKey) async {
    try {
      final response = await _dio.get('/api/v1/expense/budgets/$monthKey');
      return MonthlyBudget.fromJson(response.data);
    } on DioException catch (e) {
      appLogger.e('GET BUDGET ERROR', error: e.response?.data ?? e);
      if (e.response?.statusCode == 404) {
        // Trả về budget trống nếu chưa thiết lập
        return MonthlyBudget(monthKey: monthKey, spent: 0, exceeded: false);
      }
      throw Exception('Không thể tải ngân sách');
    } catch (e) {
      appLogger.e('GET BUDGET PARSE ERROR', error: e);
      throw Exception('Lỗi xử lý dữ liệu ngân sách');
    }
  }

  Future<MonthlyBudget> updateBudget(String monthKey, double amountLimit, int alertThresholdPct) async {
    try {
      final response = await _dio.put(
        '/api/v1/expense/budgets/$monthKey',
        data: {
          'amountLimit': amountLimit,
          'alertThresholdPct': alertThresholdPct,
        },
      );
      return MonthlyBudget.fromJson(response.data);
    } catch (e) {
      appLogger.e('UPDATE BUDGET ERROR', error: e);
      throw Exception('Không thể cập nhật ngân sách');
    }
  }

  Future<ExpenseSummary> getSummary(String monthKey) async {
    try {
      final response = await _dio.get('/api/v1/expense/summary', queryParameters: {'monthKey': monthKey});
      return ExpenseSummary.fromJson(response.data);
    } on DioException catch (e) {
      appLogger.e('GET SUMMARY ERROR', error: e.response?.data ?? e);
      if (e.response?.statusCode == 404) {
        return ExpenseSummary(
          monthKey: monthKey,
          totalSpent: 0,
          budgetExceeded: false,
          percentUsed: 0,
          byCategory: [],
        );
      }
      throw Exception('Không thể tải báo cáo chi tiêu');
    } catch (e) {
      appLogger.e('GET SUMMARY PARSE ERROR', error: e);
      throw Exception('Lỗi xử lý dữ liệu báo cáo');
    }
  }

  Future<List<ExpenseEntry>> getEntries(
    String monthKey, {
    TransactionType type = TransactionType.expense,
    int page = 0,
    int size = 100,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/expense/entries',
        queryParameters: {
          'monthKey': monthKey,
          'type': type.apiValue,
          'page': page,
          'size': size,
        },
      );
      final responseData = response.data;
      final List<dynamic> data = responseData is List
          ? responseData
          : ((responseData as Map<String, dynamic>)['content'] as List<dynamic>? ?? const []);
      return data.map((json) => ExpenseEntry.fromJson(json)).toList();
    } on DioException catch (e) {
      appLogger.e('GET ENTRIES ERROR', error: e.response?.data ?? e);
      throw Exception('Không thể tải lịch sử giao dịch');
    } catch (e) {
      appLogger.e('GET ENTRIES PARSE ERROR', error: e);
      throw Exception('Lỗi xử lý dữ liệu lịch sử giao dịch');
    }
  }

  Future<CashflowSummary> getCashflow(String monthKey) async {
    try {
      final response = await _dio.get(
        '/api/v1/expense/cashflow',
        queryParameters: {'monthKey': monthKey},
      );
      return CashflowSummary.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      appLogger.e('GET CASHFLOW ERROR', error: e.response?.data ?? e);
      if (e.response?.statusCode == 404) {
        return CashflowSummary(
          monthKey: monthKey,
          totalIncome: 0,
          totalExpense: 0,
          netCashflow: 0,
          budgetExceeded: false,
          incomeByCategory: const [],
          expenseByCategory: const [],
        );
      }
      throw Exception('Không thể tải báo cáo dòng tiền');
    } catch (e) {
      appLogger.e('GET CASHFLOW PARSE ERROR', error: e);
      throw Exception('Lỗi xử lý dữ liệu dòng tiền');
    }
  }

  Future<void> updatePhotoExpense(String photoId, {double? amount, String? note, String? categoryId}) async {
    try {
      await _dio.patch(
        '/api/v1/photos/$photoId/expense',
        data: {
          if (amount != null) 'amount': amount,
          if (note != null) 'note': note,
          if (categoryId != null) 'categoryId': categoryId,
        },
      );
    } catch (e) {
      appLogger.e('UPDATE PHOTO EXPENSE ERROR', error: e);
      throw Exception('Không thể cập nhật thông tin chi tiêu');
    }
  }
}
