import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/route/route_strings.dart';
import 'package:hiwash_partner/widgets/components/app_snack_bar.dart';
import 'package:hiwash_partner/widgets/components/countdown_else_full_date.dart';
import 'package:hiwash_partner/widgets/components/data_formet.dart';
import 'package:hiwash_partner/widgets/components/loader.dart';
import 'package:hiwash_partner/widgets/sized_box_extension.dart';
import 'package:intl/intl.dart';

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
import '../../../widgets/components/countdown_or_date_timer.dart';
import '../../../widgets/components/date_time_widget.dart';
import '../../../widgets/components/dashed_line_widget.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/is_select_button.dart';
import '../../../widgets/components/profile_image_view.dart';
import '../../reward/controller/reward_controller.dart';
import '../../reward/model/get_offers_by_id_model.dart';
import '../../rewarded_customers/controller/rewarded_customer_controller.dart';
import '../model/get_customer_data_model.dart';

class QrController extends GetxController with GetTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  RewardController rewardController =
      Get.isRegistered<RewardController>()
          ? Get.find<RewardController>()
          : Get.put(RewardController());

  RxString scanUrl = ''.obs;
  RxString customerId = ''.obs;
  RxString getOfferId = ''.obs;
  RxString internetStatus = ''.obs;
  RxBool hasScanned = false.obs;

  ///Get customer id
  Rxn<GetCustomerData> getCustomerData = Rxn();

  /// Reactive variable to notify UI of successful scan with the scanned customerId
  Rxn<String> scannedCustomerId = Rxn<String>();
  Rxn<String> scannedOfferId = Rxn<String>();

  AnimationController? animationController;
  late Animation<double> animation;
  final LocalStorage localStorage = LocalStorage();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 150).animate(animationController!);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await requestCameraPermission();
    qrController?.resumeCamera();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
      if (!result.isGranted) {
        appSnackBar(
          title: StringConstant.kPermissionDenied.tr,
          message: StringConstant.kCameraPermissionRequired.tr,
        );
      }
    }
  }

  void checkInternetConnection() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        internetStatus.value = "";
      } else {
        internetStatus.value = StringConstant.kInternetIsNotAvailable.tr;
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

        animationController?.stop();
        controller.pauseCamera();

        if (scannedCode.isNotEmpty && scannedCode.split('.').length == 3) {
          try {
            Map<String, dynamic> decodedToken = JwtDecoder.decode(scannedCode);
            print("ScanData----->${scanData.code}");

            String id = decodedToken['CustomerId'];
            String offerId = decodedToken['OfferId'];

            customerId.value = id;
            getOfferId.value = offerId;

            scannedCustomerId.value = id;
            scannedOfferId.value = offerId;

            final results = await Future.wait([
              getCustomerDataById(int.parse(id)),
              getOffersById(int.parse(offerId)),
            ]);

            final GetCustomerData? customerData =
                results[0] as GetCustomerData?;
            final GetOffersByIdModel? offerData =
                results[1] as GetOffersByIdModel?;
            final OfferDetailList? offerDetails =
                offerData?.offerDetailList?.isNotEmpty == true
                    ? offerData!.offerDetailList!.first
                    : null;

            if (customerData != null && offerDetails != null) {
              Get.back();
              Future.delayed(Duration(milliseconds: 300));
              showDialog(
                barrierDismissible: false,
                context: Get.context!,
                builder: (context) {
                  return AppDialog(
                    /*   onTap: () {
                      Get.back();
                    },*/
                    closeIconShow: false,
                    child: approveRewardDialog(customerData, offerDetails),
                    padding: EdgeInsets.zero,
                  );
                },
              );
            }
          } catch (e) {
            clearScan();

            appSnackBar(message: StringConstant.kFailedToDecodeQRCode.tr);
            Get.offAllNamed(RouteStrings.dashboardScreen);
          }
        } else {
          clearScan();
          print("Invalid QR Scanned code is not a valid JWT.");
          appSnackBar(message: StringConstant.kSomethingWentWrongTryAgain.tr);
          Get.offAllNamed(RouteStrings.dashboardScreen);
        }
      }
    });
  }

  void clearScanResult() {
    scannedCustomerId.value = null;
    scannedOfferId.value = null;
  }

  Future<GetCustomerData?> getCustomerDataById(int id) async {
    try {
      getCustomerData.value = await Repository().getCustomerData(id);

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

      return getOffersByIdModel.value;
    } catch (error) {
      print("Error fetching Offers by Di: $error");
    }
    return null;
  }

  @override
  void onClose() {
    qrController?.dispose();
    animationController?.dispose();
    super.onClose();
  }

  void clearScan() {
    scanUrl.value = '';
    customerId.value = '';
    getOfferId.value = "";
    hasScanned.value = false;
    scannedCustomerId.value = null;
    scannedOfferId.value = null;

    qrController?.resumeCamera();
    if (animationController?.isAnimating == false) {
      animationController?.repeat(reverse: true);
    }
  }

  Future validateOfferQr(String customerId, String offerIdd) async {
    Map<String, dynamic> requestBody = {
      "customerId": customerId,
      "offerId": offerIdd,
    };

    isLoading.value = true;

    try {
      var response = await Repository().validateOfferQrRepo(requestBody);

      print("Value received in controller validateOfferQr: $response");

      if (response != null && response['success'] == true) {
        /*  appSnackBar(
          message: response['message'] ?? "Offer validated successfully.",
        );*/
      } else {
        appSnackBar(
          message:
              response['message'] ?? StringConstant.kFailedToValidateOffer.tr,
        );
      }

      return response;
    } catch (e) {
      print("Error in controller while validating QR: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Widget approveRewardDialog(
    GetCustomerData customerData,
    OfferDetailList offerDetailList,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              27.heightSizeBox,
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConstant.kApproveRewardSharing.tr,
                      style: w700_18a(color: AppColor.c2C2A2A),
                    ),
                    Text(offerDetailList.offerDetails ?? "", style: w400_12p()),
                  ],
                ),
              ),
              6.heightSizeBox,

              Container(
                height: 187,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor.c2C2A2A.withOpacity(0.2)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        height: 172,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl:
                            offerDetailList.image?.isNotEmpty == true
                                ? offerDetailList.image!
                                : Assets.imagesImOffer,

                        placeholder:
                            (context, url) => Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Image.asset(
                              Assets.imagesImOffer,
                              height: 187,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CountdownElseFullDate(
                            expiryDateStr: offerDetailList.expiryDate ?? '',
                          ),

                          13.heightSizeBox,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              ProfileImageView(
                radius: 24,
                radiusStack: 6,

                imagePath:
                    customerData.data?.customerDetails?.profilePicUrl ?? '',

                isVisibleStack:
                    customerData.data?.subscriptionDetails?.isPremium,
              ),
              11.heightSizeBox,
              Text(StringConstant.kCUSTOMER.tr, style: w400_10a()),
              Text(
                customerData.data?.customerDetails?.fullName ?? "",
                style: w400_16a(color: AppColor.c2C2A2A),
              ),
              11.heightSizeBox,
              CountdownOrDateTimer(
                expiryDateStr: offerDetailList.expiryDate ?? '',
              ),
              // ImageView(path: Assets.imagesTimeView, height: 25),
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
                        StringConstant.kDecline.tr,
                        style: w500_14a(color: AppColor.cC31848),
                      ),
                    ),
                  ),
                  15.widthSizeBox,

                  Obx(() {
                    return isLoading.value
                        ? CircularProgressIndicator()
                        : GestureDetector(
                          onTap: () async {
                            isLoading.value = true;
                            Get.back();
                            try {
                              final response = await validateOfferQr(
                                customerData.data!.customerDetails!.id
                                    .toString(),
                                offerDetailList.id.toString(),
                              );

                              if (response != null) {
                                /// Toto add this line
                                await rewardController.fetchCustomersById(
                                  getOffersByIdModel
                                          .value
                                          ?.offerDetailList
                                          ?.first
                                          .id
                                          .toString() ??
                                      '',
                                );
                                //await rewardController.getRewardedCustomersById();
                                showDialog(
                                  barrierDismissible: false,
                                  context: Get.context!,
                                  builder: (context) {
                                    return AppDialog(
                                      onTap: () {
                                        Get.back();
                                      },
                                      padding: EdgeInsets.zero,
                                      child: successDialog(
                                        customerDataSuccess: customerData,
                                        offerDetailListSuccess: offerDetailList,
                                      ),
                                    );
                                  },
                                );
                              }
                            } catch (e) {
                              appSnackBar(
                                message:
                                    StringConstant
                                        .kSomethingWentWrongTryAgain
                                        .tr,
                              );
                            } finally {
                              isLoading.value = false;
                            }
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
                              StringConstant.kApprove.tr,
                              style: w500_14a(color: AppColor.white),
                            ),
                          ),
                        );
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget successDialog({
    required GetCustomerData customerDataSuccess,

    required OfferDetailList offerDetailListSuccess,
  }) {
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
              Text(
                StringConstant.kSuccesss.tr,
                style: w700_22a(color: AppColor.c2C2A2A),
              ),
              Text(
                StringConstant.kRewardHasBeenSuccessfullyShared.tr,
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
                    ProfileImageView(
                      isVisibleStack:
                          customerDataSuccess
                              .data
                              ?.subscriptionDetails
                              ?.isPremium,
                      radius: 20,
                      radiusStack: 4,

                      imagePath:
                          customerDataSuccess
                              .data
                              ?.customerDetails
                              ?.profilePicUrl,
                    ),
                    9.widthSizeBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customerDataSuccess.data?.customerDetails?.fullName ??
                              '',
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IsSelectButton(),
                            5.widthSizeBox,

                            /// Todo part of discussion which date show here
                            Text(
                              formatDate("${DateTime.now()}"),
                              style: w400_12a(color: AppColor.c455A64),
                            ),
                          ],
                        ),

                        /// Todo part of discussion
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
                              offerDetailListSuccess.title ?? '',
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
