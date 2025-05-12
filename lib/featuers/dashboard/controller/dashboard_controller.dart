import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../../network_manager/utils/api_response.dart';
import '../model/get_partner_model.dart';

class DashboardController extends GetxController {
  RxBool loading = false.obs;
  Rxn<ApiResponse> apiResponse = Rxn<ApiResponse>();
  int userRating = 0;
  final TextEditingController commentController = TextEditingController();
Rxn<GetPartnerModel> getPartnerModel=Rxn();
  final String? userId = LocalStorage().getUserId();

  @override
  void onInit() {
    super.onInit();

    if (userId != null) {
      final int? parsedId = int.tryParse(userId!);
      if (parsedId != null && parsedId > 0) {
        getPartnerDataById(parsedId);
      } else {
        print("Invalid or unparsable user ID: $userId");
      }
    } else {
      print("User ID not found in local storage");
    }
  }


  Future<GetPartnerModel?> getPartnerDataById(int id) async {
    // loading = true;\
    try {
       getPartnerModel.value= await Repository().getPartnerData(id);
      // loading = false;

      if (getPartnerModel.value?.data != null) {
        int? customerId = getPartnerModel.value?.data!.first.id;
        print("Customer ID: $customerId");
      }

      return getPartnerModel.value;
    } catch (error) {
      // loading = false;
      print("Error fetching partner data: $error");
      return null;
    }
  }

/*
  Future<ApiResponse?> getRating(
    String rating,
    String workerId,
    String locationId,
    String comment,
  ) async {
    Map params = {
      "rating": rating,
      "workerId": workerId,
      "locationId": locationId,
      "comment": comment,
    };
    try {
      print("Rating body--->: $params");
      //  loading.value = true;
      apiResponse.value = await Repository().rating(params);
      return apiResponse.value;
    } catch (e) {
      print("Error in controller: $e");
      return null;
    } finally {
      // loading.value = false;
    }

  }*/
}
