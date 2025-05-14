import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/featuers/auth/model/login_model.dart';

import '../../../generated/assets.dart';
import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../model/get_token_model.dart';
import '../model/send_otp_model.dart';
import '../model/sign_up_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  @override
  void onInit() {
    pageController.addListener(() {
      onPageChanged(pageController.page!.round());
    });
    checkLoginStatus();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
  void resetTimer() {
    startTimer();
  }
  void checkLoginStatus() {
    String? token = LocalStorage().getToken();
    if (token != null && token.isNotEmpty) {
      isLoggedIn.value = true;
      print("User already logged in ");
    } else {
      isLoggedIn.value = false;
      print("User not logged in ");
    }
  }

  GetTokenModel? getTokenModel;
  LoginModel? loginModel;
  SendOtpModel? sendOtpModel;
  SignUpModel? signUpModel;

  /// login controller
  TextEditingController loginPhoneController = TextEditingController(
    text: "6212345678901",
  );

  TextEditingController emailController = TextEditingController(
    text: "partner1@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "Hiwash@5432",
  );
  TextEditingController phoneRestController = TextEditingController();
  TextEditingController passwordRestController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  /// Welcome screen
  final PageController pageController = PageController();

  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

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

  String? validatePhoneNumberLogin(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return "Please Enter Valid Phone Number";
      }
    } else {
      return "Phone number cannot be empty";
    }
    return null;
  }

  var enteredOtp = ''.obs;
  var secondsRemaining = 30.obs;
  Timer? _timer;

  void startTimer() {
    secondsRemaining.value = 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<SendOtpModel?> sendOtp(String phoneNumber) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": phoneNumber,
      "userType": "2",
    };
    try {
      isLoading.value = true;
      sendOtpModel = await Repository().sendOtpRepo(requestBody);
      if (sendOtpModel != null) {
        Get.snackbar(
          'Success',
          "OTP: ${sendOtpModel?.data?.otp}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: AppColor.white,
        );}
      print("Value received in controller sendOtp: $sendOtpModel");
      return sendOtpModel;
    } catch (e) {
      print("Error in controller while sending OTP: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future getFCMTokenIn() async {
    var token = await FirebaseMessaging.instance.getToken();
    LocalStorage().saveFCMToken(token: token);
    debugPrint("fcmTokenSet------> $token");
  }


  Future<LoginModel?> login(String email, String password) async {
    Map<String, dynamic> requestBody = {"email": email, "password": password,
      "fcmToken":LocalStorage().getFCMToken()


    };
    isLoading.value = true;
    try {
      final value = await Repository().loginRepo(requestBody);
      print(" Value received in controller token: $value");
      loginModel = value;
      LocalStorage tokenStorage = LocalStorage();
      await tokenStorage.saveToken(value.data!.token!);
      await tokenStorage.saveUserId(value.data!.id.toString());

      return value;
    } catch (error) {
      print(" Error in controller send otp: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<GetTokenModel?> getToken(String phoneNumber) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": phoneNumber,
      "userType": "2",
    };
    print("Calling getToken with $phoneNumber");
    isLoading.value = true;

    try {
      final value = await Repository().getTokens(requestBody);
      print(" Value received in controller token: $value");
      getTokenModel = value;
      LocalStorage token = LocalStorage();
      token.saveToken(value.data?.token ?? '');

      return value;
    } catch (error) {
      print(" Error in controller send otp: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> resetPassword(String mobileNumber, String password) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": mobileNumber,
      "password": password,
    };
    isLoading.value = true;

    try {
      final value = await Repository().resetPasswordRepo(requestBody);
      print(" Value received in controller: $signUpModel");

      return value;
    } catch (error) {
      print(" Error in controller reset password: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await LocalStorage().removeToken();
    isLoggedIn.value = false;
    Get.offAllNamed(RouteStrings.welcomeScreen);
  }
}
