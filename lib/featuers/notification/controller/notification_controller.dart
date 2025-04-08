import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<bool> selectedIndices = List.generate(20, (index) => false).obs;

  void toggleSelection(int index) {
    if (index >= 0 && index < selectedIndices.length) {
      selectedIndices[index] = !selectedIndices[index];
    }
  }
}