import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';

class QrController extends GetxController with GetTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;

  RxString scanUrl = ''.obs;
  RxString customerId = ''.obs;
  RxString internetStatus = ''.obs;
  RxBool hasScanned = false.obs;

  late AnimationController animationController;
  late Animation<double> animation;
  final LocalStorage localStorage = LocalStorage();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    checkInternetConnection();
  }

  @override
  void onReady() {
    super.onReady();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 150).animate(animationController);

    qrController?.resumeCamera();
  }

  void checkInternetConnection() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
        internetStatus.value = "";
      } else {
        internetStatus.value = "Internet is not available";
      }
    });
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (!hasScanned.value) {
        final scannedCode = scanData.code ?? '';
        scanUrl.value = scannedCode;
        hasScanned.value = true;

        animationController.stop();
        controller.pauseCamera();

        if (scannedCode.isNotEmpty && scannedCode.split('.').length == 3) {
          try {
            Map<String, dynamic> decodedToken = JwtDecoder.decode(scannedCode);
            print("ScanData----->${scanData.code}");
            String id = decodedToken['CustomerId'];
            customerId.value = id;

            print("Extracted CustomerId: $id");

            await localStorage.saveUserId(id);
            await localStorage.saveScannedQrCode(scannedCode);

            await validateWashQr(id).then((value) {

              clearScan();

            });
          } catch (e) {
            Get.snackbar("Error", "Failed to decode JWT: $e");
          }
        } else {
          Get.snackbar("Invalid QR", "Scanned code is not a valid JWT");
        }
      }
    });
  }

  void onQRViewCreated1(QRViewController controller) {
    qrController = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (!hasScanned.value) {
        final scannedCode = scanData.code ?? '';
        scanUrl.value = scannedCode;
        hasScanned.value = true;

        animationController.stop();
        controller.pauseCamera();

        if (scannedCode.isNotEmpty && scannedCode.split('.').length == 3) {
          try {
            Map<String, dynamic> decodedToken = JwtDecoder.decode(scannedCode);
            String id = decodedToken['CustomerId'];
            customerId.value = id;

            print("Extracted CustomerId: $id");

            await localStorage.saveUserId(id);


          } catch (e) {
            Get.snackbar("Error", "Failed to decode JWT: $e");
          }
        } else {
          Get.snackbar("Invalid QR", "Scanned code is not a valid JWT");
        }
      }
    });
  }

  void clearScan() {
    scanUrl.value = '';
    customerId.value = '';
    hasScanned.value = false;

    qrController?.resumeCamera();
    animationController.repeat(reverse: true);
  }

  Future<dynamic> validateWashQr(String customerId) async {
    Map<String, dynamic> requestBody = {"customerId": customerId};
    try {
      isLoading.value = true;
      var response = await Repository().validateWashQrRepo(requestBody);
      print("Value received in controller validateWashQr: $response");
      return response;
    } catch (e) {
      print("Error in controller while validating QR: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    qrController?.dispose();
    animationController.dispose();
    super.onClose();
  }
}


/*
// qr_controller.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_worker/route/route_strings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';

class QrController extends GetxController with GetTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? qrController;
  RxString scanUrl = RxString('');
  RxString internetStatus = ''.obs;
  RxBool hasScanned = false.obs;

  late AnimationController animationController;
  late Animation<double> animation;
  final LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
  }

  @override
  void onReady() {
    super.onReady();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 150).animate(animationController);
  }

  void checkInternetConnection() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
        internetStatus.value = "";
      } else {
        internetStatus.value = "Internet is not available";
      }
    });
  }
  void onQRViewCreated(QRViewController controller) {
    qrController = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (!hasScanned.value) {
        final scannedCode = scanData.code ?? '';
        scanUrl.value = scannedCode;
        hasScanned.value = true;

        animationController.stop();
        controller.pauseCamera();

        if (scannedCode.isNotEmpty && scannedCode.split('.').length == 3) {
          try {
            Map<String, dynamic> decodedToken = JwtDecoder.decode(scannedCode);
            String customerId = decodedToken['CustomerId'];

            print("Extracted CustomerId: $customerId");

            final localStorage = LocalStorage();
            await localStorage.saveCustomerId(customerId);

            await validateWashQr(customerId).then((value){
              Get.offAllNamed(RouteStrings.dashboardScreen);
            });
          } catch (e) {
            Get.snackbar("Error", "Failed to decode JWT: $e");
          }
        } else {
          Get.snackbar("Invalid QR", "Scanned code is not a valid JWT");
        }
      }
    });
  }


*/
/*  void onQRViewCreated(QRViewController controller) {
    qrController = controller;

    controller.scannedDataStream.listen((scanData) {
      if (!hasScanned.value) {
        print("Scanned QR Data: ${scanData.code}");

        scanUrl.value = scanData.code ?? '';
        hasScanned.value = true;

        animationController.stop();
        controller.pauseCamera();
      }
    });
  }*//*


  void clearScan() {
    scanUrl.value = '';
    hasScanned.value = false;

    qrController?.resumeCamera();
    animationController.repeat(reverse: true);
  }

  @override
  void onClose() {
    qrController?.dispose();
    animationController.dispose();
    super.onClose();
  }
  var isLoading = false.obs;



  Future<dynamic> validateWashQr(String customerId) async {
    Map<String, dynamic> requestBody = {"customerId": customerId};
    try {
      isLoading.value = true;
      var response = await Repository().validateWashQrRepo(requestBody);
      print("Value received in controller sendOtp: $response");
      return response;
    } catch (e) {
      print("Error in controller while sending OTP: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }



}
*/
