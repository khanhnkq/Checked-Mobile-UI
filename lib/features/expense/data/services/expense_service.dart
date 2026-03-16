import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/network/dio_client.dart';
import '../models/expense_models.dart';

class ExpenseService {
  final Dio _dio = DioClient().dio;

  Future<List<ExpenseCategory>> getCategories() async {
    try {
      final response = await _dio.get('/api/v1/expense/categories');
      final List<dynamic> data = response.data;
      return data.map((json) => ExpenseCategory.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint('GET CATEGORIES ERROR: ${e.response?.data}');
      throw Exception('Không thể tải danh mục chi tiêu');
    } catch (e) {
      debugPrint('GET CATEGORIES PARSE ERROR: $e');
      throw Exception('Lỗi xử lý dữ liệu danh mục');
    }
  }

  Future<MonthlyBudget> getBudget(String monthKey) async {
    try {
      final response = await _dio.get('/api/v1/expense/budgets/$monthKey');
      return MonthlyBudget.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('GET BUDGET ERROR: ${e.response?.data}');
      if (e.response?.statusCode == 404) {
        // Trả về budget trống nếu chưa thiết lập
        return MonthlyBudget(monthKey: monthKey, spent: 0, exceeded: false);
      }
      throw Exception('Không thể tải ngân sách');
    } catch (e) {
      debugPrint('GET BUDGET PARSE ERROR: $e');
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
      debugPrint('UPDATE BUDGET ERROR: $e');
      throw Exception('Không thể cập nhật ngân sách');
    }
  }

  Future<ExpenseSummary> getSummary(String monthKey) async {
    try {
      final response = await _dio.get('/api/v1/expense/summary', queryParameters: {'monthKey': monthKey});
      return ExpenseSummary.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('GET SUMMARY ERROR: ${e.response?.data}');
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
      debugPrint('GET SUMMARY PARSE ERROR: $e');
      throw Exception('Lỗi xử lý dữ liệu báo cáo');
    }
  }

  Future<List<ExpenseEntry>> getEntries(String monthKey) async {
    try {
      final response = await _dio.get('/api/v1/expense/entries', queryParameters: {'monthKey': monthKey});
      final List<dynamic> data = response.data is List ? response.data : (response.data['content'] ?? []);
      return data.map((json) => ExpenseEntry.fromJson(json)).toList();
    } catch (e) {
      debugPrint('GET ENTRIES ERROR: $e');
      throw Exception('Không thể tải lịch sử chi tiêu');
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
      debugPrint('UPDATE PHOTO EXPENSE ERROR: $e');
      throw Exception('Không thể cập nhật thông tin chi tiêu');
    }
  }
}
