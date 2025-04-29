// qr_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/is_select_button.dart';
import '../controller/qr_controller.dart';


class QrScreen extends StatelessWidget {
  QrScreen({super.key});

  final QrController controller = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    final int? washId = Get.arguments;

    return Scaffold(
      backgroundColor: AppColor.cF6F7FF.withOpacity(0.2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: controller.clearScan,
            child: Text(
              "Clear",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),

          Center(
            child: Container(
              alignment: Alignment.center,
              width: Get.width / 1.2,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  QRView(
                    key: controller.qrKey,
                    onQRViewCreated: washId != null
                        ? controller.onQRViewCreated1
                        : controller.onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      overlayColor: AppColor.c101D8D.withOpacity(0.5),
                      borderRadius: 10,
                      borderLength: 50,
                      borderWidth: 20,
                      cutOutSize: 300,
                    ),
                  ),
                  Obx(() {
                    // Add safety check for animationController being initialized
                    if (controller.scanUrl.value.isEmpty &&
                        controller.animationController != null &&
                        controller.animationController.isAnimating) {
                      return AnimatedBuilder(
                        animation: controller.animationController,
                        builder: (context, child) {
                          return Positioned(
                            top: controller.animation.value,
                            child: Container(
                              width: 280,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColor.cFFC727,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),

                  /*   Obx(() {
                    if (controller.scanUrl.value.isEmpty &&
                        controller.animationController.isAnimating) {
                      return AnimatedBuilder(
                        animation: controller.animationController,
                        builder: (context, child) {
                          return Positioned(
                            top: controller.animation.value,
                            child: Container(
                              width: 280,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColor.cFFC727,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),*/


                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Obx(
            () => Column(
              children: [
                Text(
                  controller.customerId.value.isNotEmpty
                      ? 'Customer ID: ${controller.customerId.value}'
                      : 'Scan a QR code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                if (controller.internetStatus.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      controller.internetStatus.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
