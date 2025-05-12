

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_partner/route/route_strings.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../generated/assets.dart';
import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/date_time_widget.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/is_select_button.dart';
import '../../../widgets/components/profile_image_view.dart';
import '../../reward/model/get_offers_by_id_model.dart';
import '../model/get_customer_data_model.dart';

class QrController extends GetxController with GetTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;

  RxString scanUrl = ''.obs;
  RxString customerId = ''.obs;
  RxString getOfferId = ''.obs;
  RxString internetStatus = ''.obs;
  RxBool hasScanned = false.obs;

  /// Reactive variable to notify UI of successful scan with the scanned customerId
  Rxn<String> scannedCustomerId = Rxn<String>();
  Rxn<String> scannedOfferId = Rxn<String>();

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
  Future<void> onReady() async {
    super.onReady();
    await requestCameraPermission();
  /*  animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
*/
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 150).animate(animationController);

    qrController?.resumeCamera();
  }


  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
      if (!result.isGranted) {
        Get.snackbar("Permission Denied", "Camera permission is required to scan QR codes.");
      }
    }
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


  /// Todo Not working Get back
/*
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
            String offerId = decodedToken['OfferId'];

            customerId.value = id;
            getOfferId.value = offerId;

            var validationResponse = await validateOfferQr(id, offerId);

            if (validationResponse != null) {
              scannedCustomerId.value = id;
              scannedOfferId.value = offerId;

              final results = await Future.wait([
                getCustomerDataById(int.parse(id)),
                getOffersById(int.parse(offerId)),
              ]);

              final GetCustomerData? customerData = results[0] as GetCustomerData?;
              final GetOffersByIdModel? offerDetail = results[1] as GetOffersByIdModel?;

              if (customerData != null && offerDetail != null) {
                clearScan();
                await Future.delayed(Duration(milliseconds: 300));
                Get.dialog(
                  approveRewardDialog(customerData, offerDetail),
                  barrierDismissible: false,
                );
              } else {
              }
            } else {
              Get.back();

            }
          } catch (e) {

          }
        } else {
         // clearScan();



        }
      }
    });
  }


*/

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
            String offerId = decodedToken['OfferId'];

            customerId.value = id;
            getOfferId.value = offerId;

            var validationResponse = await validateOfferQr(id, offerId);

            if (validationResponse != null) {
              scannedCustomerId.value = id;
              scannedOfferId.value = offerId;

              final results = await Future.wait([
                getCustomerDataById(int.parse(id)),
                getOffersById(int.parse(offerId)),
              ]);

              final GetCustomerData? customerData = results[0] as GetCustomerData?;
              final GetOffersByIdModel? offerDetail = results[1] as GetOffersByIdModel?;

              if (customerData != null && offerDetail != null) {
                //clearScan();
                 Future.delayed(Duration(milliseconds: 300));
                Get.dialog(
                 await approveRewardDialog(customerData, offerDetail),
                  barrierDismissible: false,
                );
              }
            }else{
              await Future.delayed(Duration(seconds: 1));
              Get.back();
              await Future.delayed(Duration(seconds: 1));

              Get.back()
;            }
          } catch (e) {
            clearScan();
            Get.snackbar("Error", "Failed to decode QR code.");
            Get.offAllNamed(RouteStrings.dashboardScreen);
          }
        } else {
          clearScan();
          Get.snackbar("Invalid QR", "Scanned code is not a valid JWT.");
          Get.offAllNamed(RouteStrings.dashboardScreen);
        }
      }
    });
  }





  void clearScan() {
    scanUrl.value = '';
    customerId.value = '';
    getOfferId.value="";
    hasScanned.value = false;
    scannedCustomerId.value = null;
    scannedOfferId.value = null;

    qrController?.resumeCamera();
    animationController.repeat(reverse: true);
  }

  void clearScanResult() {
    scannedCustomerId.value = null;
    scannedOfferId.value = null;
  }

  ///Get customer id
  Rxn<GetCustomerData> getCustomerData=Rxn();
  Future<GetCustomerData?> getCustomerDataById(int id) async {

    try {
      getCustomerData.value= await Repository().getCustomerData(id);

      getCustomerData.value;
      getCustomerData.refresh();
      return getCustomerData.value;
    } catch (error) {

      print("Error fetching customer data: $error");
      return null;
    }

  }

  ///  Get offer id by id
  Rxn<GetOffersByIdModel> getOffersByIdModel = Rxn();
  Future<GetOffersByIdModel?> getOffersById(int id) async {
    try {

      getOffersByIdModel.value = await Repository().getOfferById(id);

      getOffersByIdModel.value;
    } catch (error) {


      print("Error fetching Offers by Di: $error");
    }
    return null;
  }

  @override
  void onClose() {
    qrController?.dispose();
    animationController.dispose();
    super.onClose();
  }

  Future validateOfferQr(String customerId, String offerIdd) async {
    Map<String, dynamic> requestBody = {
      "customerId": customerId,
      "offerId": offerIdd,
    };

    try {
     var response = await Repository().validateOfferQrRepo(requestBody);
      print("Value received in controller validateOfferQr: $response");
      return response;
    } catch (e) {
      print("Error in controller while validating QR: $e");
      return null;
    }
  }


  Widget approveRewardDialog(GetCustomerData customerData, GetOffersByIdModel offerDetail) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              27.heightSizeBox,
              Text(
                "Approve Reward Sharing",
                style: w700_18a(color: AppColor.c2C2A2A),
              ),
              Text("Special Offers & FREE Coupons.", style: w400_12p()),
              6.heightSizeBox,
              Container(
                width: Get.width,

                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageView(path: Assets.imagesImOffer),
                    ),
                    Positioned(
                      top: 35,
                      left: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateTimeWidget(
                            title: "0:3 HRS - 34 MINS",
                            textColor: AppColor.c000000,
                            color: AppColor.white.withOpacity(0.5),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Special Offers\nFREE Accessories",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rumRaisin(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 17,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: ImageView(
                          path: Assets.imagesDemo,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              ProfileImageView(radius: 24, radiusStack: 6),
              11.heightSizeBox,
              Text("CUSTOMER", style: w400_10a()),
              Text("Ibrahim Bafqia", style: w400_16a(color: AppColor.c2C2A2A)),
              11.heightSizeBox,
              ImageView(path: Assets.imagesTimeView, height: 25),
              22.heightSizeBox,
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cF6F7FF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              DashedLineWidget(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 21, bottom: 21),
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.cC31848),
                      ),
                      child: Text(
                        "Decline",
                        style: w500_14a(color: AppColor.cC31848),
                      ),
                    ),
                  ),
                  15.widthSizeBox,
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: Get.context!,
                        builder: (context) {
                          return AppDialog(
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: successDialog(),
                            padding: EdgeInsets.zero,
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.c1F9D70,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.c1F9D70.withOpacity(0.30),
                            spreadRadius: 0,
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Text(
                        "Approve",
                        style: w500_14a(color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget successDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              30.heightSizeBox,
              Container(
                width: Get.width,

                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageView(
                        path: Assets.imagesImSussess,
                        width: Get.width,
                        height: 222,
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              Text("Success!", style: w700_22a(color: AppColor.c2C2A2A)),
              Text(
                "Reward Has Been\nSuccessfully Shared!",
                textAlign: TextAlign.center,
                style: w400_16p(),
              ),
              18.heightSizeBox,
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cF6F7FF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              DashedLineWidget(),

              Padding(
                padding: EdgeInsets.only(top: 23, left: 19, bottom: 23),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileImageView(radius: 20, radiusStack: 4),
                    9.widthSizeBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ibrahim Bafqia",
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IsSelectButton(),
                            5.widthSizeBox,
                            Text(
                              "09-May-2024",
                              style: w400_12a(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: DotedVerticalLine(height: 5),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IsSelectButton(),
                            5.widthSizeBox,
                            Text(
                              "Buy 1 Get 1 Free ",
                              style: w400_10a(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

