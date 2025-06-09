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
  Rxn<GetPartnerModel> getPartnerModel = Rxn();
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
    try {
      getPartnerModel.value = await Repository().getPartnerData(id);

      if (getPartnerModel.value?.data != null) {
        int? customerId = getPartnerModel.value?.data!.first.id;
        print("Customer ID: $customerId");
      }

      return getPartnerModel.value;
    } catch (error) {
      print("Error fetching partner data: $error");
      return null;
    }
  }
}
