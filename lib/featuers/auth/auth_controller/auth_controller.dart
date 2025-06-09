import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_partner/featuers/auth/model/login_model.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/widgets/components/app_snack_bar.dart';

import '../../../generated/assets.dart';
import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../../route/route_strings.dart';
import '../model/send_otp_model.dart';
import '../model/sign_up_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  LoginModel? loginModel;
  Rx<SendOtpModel> sendOtpModel = SendOtpModel().obs;
  SignUpModel? signUpModel;

  /// login controller
  TextEditingController loginPhoneController = TextEditingController(
    text: kDebugMode ? "6212345678901" : "",
  );

  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "partner1@gmail.com" : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "Hiwash@54321" : "",
  );
  TextEditingController phoneRestController = TextEditingController();
  TextEditingController passwordRestController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  var enteredOtp = ''.obs;
  var secondsRemaining = 30.obs;
  Timer? _timer;


  /// Welcome screen
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isPasswordVisibleLogin = false.obs;

  void togglePasswordVisibilityLogin() {
    isPasswordVisibleLogin.value = !isPasswordVisibleLogin.value;
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

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstant.kEMailIsRequired.tr;
    } else if (!RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(value)) {
      return StringConstant.kPleaseEnterAValidEmail.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstant.kPasswordIsRequired.tr;
    }
    if (value.length < 8) {
      return StringConstant.kPasswordMustBeAtLeast.tr;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return StringConstant.kPasswordMustContainAtLeastOneUpperCaseLetter.tr;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return StringConstant.kPasswordMustContainAtLeastOneLowerCaseLetter.tr;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return StringConstant.kPasswordMustContainAtLeastOneDigit.tr;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return StringConstant.PasswordMustContainAtLeastOneSpecialCharacter.tr;
    }
    return null;
  }

  String? validatePhoneNumberLogin(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return StringConstant.kPleaseEnterValidPhoneNumber.tr;
      }
    } else {
      return StringConstant.kPhoneNumberCannotBeEmpty.tr;
    }
    return null;
  }

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
      sendOtpModel.value = await Repository().sendOtpRepo(requestBody);
      if (sendOtpModel != null) {
        appSnackBar(
          title: StringConstant.kSuccess,
          message:
              "${StringConstant.kTestOTP.tr} ${sendOtpModel.value.data?.otp}",
          backgroundColor: Colors.green,
        );
      }
      print("Value received in controller sendOtp: $sendOtpModel");
      return sendOtpModel.value;
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
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
      "fcmToken": LocalStorage().getFCMToken(),
    };
    isLoading.value = true;
    try {
      final value = await Repository().loginRepo(requestBody);
      print(" Value received in controller token: $value");
      loginModel = value;
      LocalStorage tokenStorage = LocalStorage();
      await tokenStorage.saveToken(value.data!.token!);
      await tokenStorage.saveUserId(value.data!.id.toString());
      await tokenStorage.saveRefreshToken(value.data!.refreshToken!);

      return value;
    } catch (error) {
      print(" Error in controller login : $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<LoginModel?> refreshToken() async {
    final storedRefreshToken = LocalStorage().getRefreshToken();

    if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
      print("No refresh token found, user needs to login again.");
      Get.offAllNamed(RouteStrings.welcomeScreen);
      return null;
    }

    Map<String, dynamic> requestBody = {"refreshToken": storedRefreshToken};

    print("Calling refreshToken API");
    isLoading.value = true;

    try {
      final response = await Repository().refreshToken(requestBody);
      print("Refresh token response: $response");

      if (response.data?.token != null && response.data!.token!.isNotEmpty) {
        await LocalStorage().saveToken(response.data!.token!);
      }

      if (response.data?.refreshToken != null &&
          response.data!.refreshToken!.isNotEmpty) {
        await LocalStorage().saveRefreshToken(response.data!.refreshToken!);
      }

      isLoggedIn.value = true;
      return response;
    } catch (error) {
      print("Error refreshing token: $error");
      await LocalStorage().removeToken();
      Get.offAllNamed(RouteStrings.welcomeScreen);
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
