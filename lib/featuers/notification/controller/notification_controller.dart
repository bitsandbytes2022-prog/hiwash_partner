import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/featuers/notification/model/notification.dart';
import '../../../network_manager/repository.dart';
import 'package:flutter/material.dart';

class NotificationController extends GetxController {
  RxList<NotificationData> notifications = <NotificationData>[].obs;
  RxList<RxBool> selectedStates = <RxBool>[].obs;

  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  RxInt currentPage = 1.obs;
  RxInt pageSize = 10.obs;
  RxString errorMessage = ''.obs;

  final ScrollController scrollController = ScrollController();

/*
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
    fetchInitialNotifications();
  }
*/

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
      if (!isLoading.value && hasMore.value) {
        getNotification();
      }
    }
  }

  void fetchInitialNotifications() {
    currentPage.value = 1;
    hasMore.value = true;
    notifications.clear();
    selectedStates.clear();
    getNotification();
  }

  Future<void> getNotification() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await Repository().getNotificationRepo({
        "pageNo": currentPage.value.toString(),
        "pageSize": pageSize.value.toString(),
      });

      final NotificationModel model = NotificationModel.fromJson(response);

      if (model.success == true) {
        final newNotifications = model.notificationData ?? [];

        if (newNotifications.isNotEmpty) {
          notifications.addAll(newNotifications);
          selectedStates.addAll(List.generate(newNotifications.length, (_) => false.obs));
          currentPage.value++;

          if (newNotifications.length < pageSize.value) {
            hasMore.value = false;
          }
        } else {
          hasMore.value = false;
        }
      } else {
        errorMessage.value = model.message ?? "Failed to load notifications.";
      }
    } catch (e) {
      errorMessage.value = "Error fetching notifications: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelection(int index) {
    if (index >= 0 && index < selectedStates.length) {
      selectedStates[index].value = !selectedStates[index].value;
    }
  }

  void updateNotificationReadStatus(NotificationData item, int index) {
    if (item.isRead == true) return;

    item.isRead = true;

    if (index >= 0 && index < notifications.length) {
      notifications[index] = item;
    }

    if (index >= 0 && index < selectedStates.length) {
      selectedStates[index].value = true;
    }
  }
}



