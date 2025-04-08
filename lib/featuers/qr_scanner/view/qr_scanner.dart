import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_partner/generated/assets.dart';
import 'package:hiwash_partner/styling/app_color.dart';
import 'package:hiwash_partner/styling/app_font_anybody.dart';
import 'package:hiwash_partner/widgets/components/image_view.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {


  String? scanUrl;
  String internetStatus="";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Future<void> checkInternetConnection() async {
    Connectivity().onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResult) {
      setState(() {
        if (connectivityResult.contains(ConnectivityResult.mobile) ||
            connectivityResult.contains(ConnectivityResult.wifi)) {
          internetStatus = "";
        } else {
          internetStatus = "Internet is not available";
        }
      });
    });

  }
  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scanUrl = scanData.code;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ImageView(
            path: Assets.imagesQrBg,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            /*  Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 180,

                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: onQRViewCreated,
                    ),
                  ),
                  ImageView(
                    height: 210,
                    width: 210,
                    path:Assets.imagesMainQrBg,
                  )
                ],
              ),*/
              Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,

                child: QRView(
                  key: qrKey,
                  onQRViewCreated: onQRViewCreated,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        scanUrl != null ? 'Scanned URL: $scanUrl' : 'Scan a QR code',
                        textAlign: TextAlign.center,style: w700_16a(color: AppColor.white),
                      ),
                      const SizedBox(height: 20),
                      if(internetStatus.isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.transparent,
                          child: Text(
                            "Internet is not available",
                            style: TextStyle(color:Colors.white ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}