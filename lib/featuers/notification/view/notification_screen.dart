import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/language/String_constant.dart';

import '../../../generated/assets.dart';
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
    return Obx(() {
      if (controller.isLoading.value && controller.notifications.isEmpty) {
        return _buildLoadingIndicator();
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return SizedBox();
      }

      if (controller.notifications.isNotEmpty) {
        return ListView.separated(
          shrinkWrap: true,
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
        return Center(child: Text(StringConstant.kNoNotificationFound.tr));
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
    return Center(child: CircularProgressIndicator());
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
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColor.blue.withOpacity(0.2)),
              ),
              child: CircleAvatar(
                backgroundColor: AppColor.c142293.withOpacity(0.2),
                radius: 20,

                child: Image.asset(
                  item.notificationType == 0
                      ? Assets.iconsIcAlert
                      : Assets.iconsIcInfo,
                  height: 20,
                  width: 20,
                  color: AppColor.c000000,
                ),
              ),
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
