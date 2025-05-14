import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../styling/app_color.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/data_formet.dart';

import '../../../widgets/components/profile_image_view.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';


import '../../../widgets/components/doted_horizontal_line.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {

    controller.scrollController.addListener(controller.scrollListener);
   controller.fetchInitialNotifications();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      if (controller.isLoading.value &&
          controller.notifications.isEmpty) {
        return _buildLoadingIndicator();
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return _buildErrorMessage();
      }

      if (controller.notifications.isNotEmpty) {
        return ListView.separated(
          controller: controller.scrollController,
          padding: const EdgeInsets.only(top: 1, bottom: 40),
          itemCount:
          controller.notifications.length +
              (controller.hasMore.value ? 1 : 0),
          separatorBuilder: (context, index) => DotedHorizontalLine(),
          itemBuilder: (context, index) {
            if (index < controller.notifications.length) {
              final item = controller.notifications[index];
              return Obx(() => _notificationContainer(item, index));
            } else {
              return _buildPaginationLoader();
            }
          },
        );
      } else {
        return const Center(child: Text("No Notifications Found"));
      }
    });
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildPaginationLoader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
          ElevatedButton(
            onPressed: () {
              controller.fetchInitialNotifications();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }



  Widget _notificationContainer(NotificationData item, int index) {
    return GestureDetector(
      onTap: () {
        controller.toggleSelection(index);
        controller.updateNotificationReadStatus(item, index);
      },
      child: Container(
        width: Get.width,
        color:
            controller.selectedStates[index].value
                ? AppColor.white
                : AppColor.cF6F7FF,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileImageView(
              radiusStack: 5,
              isVisibleStack: false,
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.message ?? '',
                    style: w500_12p(color: AppColor.c2C2A2A),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatDate(item.createdAt),
                    style: w400_10p(color: AppColor.c455A64),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
