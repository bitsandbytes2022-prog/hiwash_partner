import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiwash_partner/route/route_strings.dart';
import 'package:hiwash_partner/route/routes.dart';
import 'package:hiwash_partner/styling/app_theam.dart';


import 'featuers/dashboard/view/dashbord_screen.dart';
import 'featuers/notification/services/notification_services.dart';
import 'firebase_options.dart';
import 'language/languages.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  NotificationServices notificationServices = NotificationServices();

  await notificationServices.firebaseInit();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
         locale:Locale('en','US'),
          translations: Languages(),
          debugShowCheckedModeBanner: false,
          title: 'Hiwash partner',
          theme: LightTheme.theme(),
    // home: HomeScreen(),
        initialRoute: RouteStrings.splashScreen,
          getPages: Routes.pages,
        );
      },
    );
  }
}
