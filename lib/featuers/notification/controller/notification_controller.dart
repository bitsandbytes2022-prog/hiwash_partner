import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../model/notification.dart';
class NotificationController extends GetxController {
  RxList<RxBool> selectedStates = <RxBool>[].obs;
  Rxn<NotificationModel> notificationModel = Rxn();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotification();
    });
  }

  void toggleSelection(int index) {
    if (index >= 0 && index < selectedStates.length) {
      selectedStates[index].value = !selectedStates[index].value;
    }
  }

  Future<void> getNotification() async {

    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await Repository().notificationRepo();
      notificationModel.value = response;


      if (response.data != null) {
        selectedStates.value = List.generate(response.data!.length, (_) => false.obs);
      } else {
        selectedStates.clear();
      }
    } catch (error) {
      errorMessage.value = "Error fetching notifications, please try again.";
      print("Error fetching notifications: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
/*
class NotificationController extends GetxController {
  RxList<RxBool> selectedStates = <RxBool>[].obs;
  Rxn<NotificationModel> notificationModel = Rxn();
  RxBool isWashSelected = true.obs;
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotification();
    });
  }

  void toggleSelection(int index) {
    if (index >= 0 && index < selectedStates.length) {
      selectedStates[index].value = !selectedStates[index].value;
    }
  }

  Future<NotificationModel?> getNotification() async {
   int id=0;
   showLoader();
    try {

      final response = await Repository().notificationRepo(id);
      notificationModel.value = response;
      return notificationModel.value;
    } catch (error) {
      print("Error fetching notifications: $error");
    } finally {

      hideLoader();
    }
    return null;
  }

}
*/
