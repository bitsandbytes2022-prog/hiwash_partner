import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

@override
  void onInit() {
  pageController.addListener(() {
    onPageChanged(pageController.page!.round());
  });
    super.onInit();
  }
/// login controller
  TextEditingController emailController = TextEditingController(text: "abcd@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "Abcd@123");
  ///signup controller


/// forgot password controller
  TextEditingController phoneForgotController = TextEditingController();

/// rest password controller
TextEditingController passwordRestController = TextEditingController();
TextEditingController cPasswordRestController = TextEditingController();


  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  /// Welcome screen
  final PageController pageController = PageController();


var currentPage = 0.obs;


void onPageChanged(int index) {
  currentPage.value = index;
}
  final List<String> headingText = [
    "Caltex Engine Oil","Wash & Win!","kEcoCleanWalletGreen",


  ]; final List<String> subText = [
    "Unlock Exclusive Perks! Enjoy more earnings, customer rewards, and premium support as our valued partner!y",
    "Get your car washed weekly at 100+ locations with exclusive offers.Missed washes still deducted.",
    "kExclusiveDealsWithEvery",

  ];





  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "E-mail is required";
    } else if (!RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(value)) {
      return "Please Enter A Valid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  ///  name validation
  String? validateName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return "First Name Is Required";
    } else if (value.length < 3) {
      return "name Must Be AtLeast 3 Characters";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Name Must Only Contain Alphabets";
    }
    return null;
  }

  /// phone number
  String? validatePhoneNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return "Please Enter Valid Phone Number";
      }
    }
    return null;
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Required";
    }
    return null;
  }
}
