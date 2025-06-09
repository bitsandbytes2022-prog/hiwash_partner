// qr_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/language/String_constant.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../styling/app_color.dart';
import '../controller/qr_controller.dart';

class QrScreen extends StatefulWidget {
  QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final QrController controller = Get.put(QrController());


  @override
  void initState() {
    controller.clearScan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColor.cF6F7FF.withOpacity(0.2),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: controller.clearScan,
            child: Text(
              StringConstant.kClear.tr,
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
                    onQRViewCreated: controller.onQRViewCreated,
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
                    if (controller.scanUrl.value.isEmpty &&
                        controller.animationController != null &&
                        controller.animationController!.isAnimating) {
                      return AnimatedBuilder(
                        animation: controller.animationController!,
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
                      ? '${StringConstant.kCustomerID.tr} ${controller.customerId.value}'
                      : StringConstant.kScanAQRCode.tr,
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
          Obx(() {
            print("ScanUrl----->${controller.scanUrl.value}");
            return Text(
              controller.getOfferId.value.isNotEmpty
                  ? '${StringConstant.kOfferID.tr}${controller.getOfferId.value}'
                  : StringConstant.kScanAQRCode.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            );
          }),
        ],
      ),
    );
  }
}
