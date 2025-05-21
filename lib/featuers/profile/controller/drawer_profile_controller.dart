import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hiwash_partner/widgets/components/loader.dart';
import '../../../network_manager/repository.dart';
import '../model/terms_and_conditions_response_model.dart';
import 'package:image_picker/image_picker.dart';

class DrawerProfileController extends GetxController {
  RxBool isLoading = false.obs;
  var  imageFile = Rx<File?>(null);
  var isSwitchOn = false.obs;
  RxBool isUploadingProfileImage = false.obs;

  Future<void> imagePicker({required ImageSource source}) async {
    var pickedFile = await ImagePicker().pickImage(source: source,imageQuality: 20);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path,  );
    } else {
      print("No file selected");
    }
  }

  var currentDrawerSection = ''.obs;
  TextEditingController businessNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();

  TextEditingController zoneController = TextEditingController(text:kDebugMode? "Zone 50":"");
  TextEditingController streetController = TextEditingController(
    text: kDebugMode?"al Matar Street":""
  );
  TextEditingController buildingController = TextEditingController(
    text:kDebugMode? 'Abcd':"",
  );
  TextEditingController unitController = TextEditingController(text:kDebugMode? 'Abcd':"");

  Rxn<TermsAndConditionsResponseModel> termsAndConditionsResponseModel = Rxn();

  void toggleDrawer(String section) {
    if (currentDrawerSection.value == section) {
      currentDrawerSection.value = '';
    } else {
      currentDrawerSection.value = section;
    }
  }


  Future<dio.FormData> getFormDataForUpload() async {
    if (imageFile == null) {}

    final fileName = imageFile.value?.path.split('/').last;
    var file = await dio.MultipartFile.fromFile(
      imageFile.value!.path,
      filename: fileName,
    );
    return dio.FormData.fromMap({"file": file});
  }

  Future<bool> uploadProfileImage() async {
    isUploadingProfileImage.value = true;
    try {
      final formData = await getFormDataForUpload();
      final response = await Repository().uploadProfilePicture(formData);

      if (response != null && response['success'] == true) {
        return true;
      } else {
        imageFile.value = null;
        return false;
      }
    } catch (e) {
      imageFile.value = null;
      return false;
    } finally {
      isUploadingProfileImage.value = false;
    }
  }

/*  Future<dynamic> uploadProfileImage() async {
    try {
      showLoader();
      final formData = await getFormDataForUpload();
      final response = await Repository().uploadProfilePicture(formData);
     hideLoader();
      return response;
    } catch (e) {
      print("Upload error: $e");
    }
  }*/

  Future<TermsAndConditionsResponseModel?> getTermsAndConditions() async {
    var entityType = 0;
    try {
      termsAndConditionsResponseModel.value = await Repository()
          .getTermsAndConditions(entityType);
      return termsAndConditionsResponseModel.value;
    } catch (error) {
      print("Error fetching Terms And Condition: $error");
      return null;
    }
  }



  Future<dynamic> uploadProfile(
      String businessName,
      String phone,
      String address,
      ) async {

    try {
      showLoader()
;      Map<String, dynamic> requestBody = {
        "businessName": businessName,
        "phone": phone,
        "address": address,
      };

      final response = await Repository().uploadProfile(requestBody);
hideLoader();
      return response;
    } catch (e) {
      print("Update profile error: $e");

      Get.snackbar(
        "Error",
        "Something went wrong while updating profile",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }}

/*
  Future<dynamic> uploadProfile(
      String fullName,
      String email,
      String mobileNumber,
      String zone,
      String street,
      String building,
      String unit,
      String profilePic,
      String carNumber,
      ) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> requestBody = {
        "fullName": fullName,
        "email": email,
        "mobileNumber": mobileNumber,
        "zone": zone,
        "street": street,
        "building": building,
        "unit": unit,
        "profilePic": profilePic,
        "carNumber": carNumber,
      };

      final response = await Repository().uploadProfile(requestBody);

      return response;
    } catch (e) {
      print("Update profile error: $e");

      Get.snackbar(
        "Error",
        "Something went wrong while updating profile",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }
*/



}
