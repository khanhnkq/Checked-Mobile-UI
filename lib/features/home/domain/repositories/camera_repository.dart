import 'package:camera/camera.dart';

import '../../../expense/data/models/expense_models.dart';
import '../../data/models/photo_models.dart';

abstract class CameraRepository {
  Future<List<CameraDescription>> getAvailableCameras();
  CameraController createController(CameraDescription camera);
  Future<XFile?> takePicture(CameraController controller);
  Future<PhotoResponse?> uploadCapturedPhoto({
    required String filePath,
    double? amount,
    String? categoryId,
    String recipientScope,
    List<String>? recipientIds,
    TransactionType transactionType = TransactionType.expense,
  });
}

