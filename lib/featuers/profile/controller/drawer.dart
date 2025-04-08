import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var currentDrawerSection = ''.obs;

  void toggleDrawer(String section) {
    if (currentDrawerSection.value == section) {
      currentDrawerSection.value = '';
    } else {
      currentDrawerSection.value = section;
    }
  }
}
