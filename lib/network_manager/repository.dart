import 'package:dio/dio.dart';
import 'package:hiwash_partner/featuers/auth/model/login_model.dart';


import '../featuers/auth/model/get_token_model.dart';
import '../featuers/auth/model/send_otp_model.dart';
import '../featuers/auth/model/sign_up_model.dart';
import '../featuers/dashboard/model/get_partner_model.dart';

import '../featuers/dashboard/view/widget/second_drawer/model/faq_response_model.dart';
import '../featuers/dashboard/view/widget/second_drawer/model/guides_response_model.dart';
import '../featuers/profile/model/terms_and_conditions_response_model.dart';
import '../featuers/qr_scanner/model/get_customer_data_model.dart';
import '../featuers/reward/model/get_offers_by_id_model.dart';
import '../featuers/reward/model/get_rewarded_customers_model.dart';
import '../featuers/reward/model/offer_response_model.dart';
import 'api_constant.dart';
import 'dio_helper.dart';
import 'local_storage.dart';

class Repository {
  final DioHelper dioHelper = DioHelper();
  final LocalStorage localStorage = LocalStorage();

  Future<SendOtpModel> sendOtpRepo(Object requestBody) async {
    print(" sendOtp body--->: $requestBody");
    print(" sendOtp url--->: ${ApiConstant.sendOtp}");

    var response = await dioHelper.post(
      url: ApiConstant.sendOtp,
      requestBody: requestBody,
    );
    print("SendOtp Response--->: $response");
    return SendOtpModel.fromJson(response);
  }


  Future<LoginModel> loginRepo(Object requestBody) async {
    var response = await dioHelper.post(
        url: ApiConstant.login, requestBody: requestBody);

    return LoginModel.fromJson(response);
  }


  Future<dynamic> resetPasswordRepo(Object requestBody) async {
    var response = await dioHelper.post(
        url: ApiConstant.resetPassword, requestBody: requestBody);
    print("Reset Response--->: $response");
    return response;
  }

  Future<GetTokenModel> getTokens(Object requestBody) async {
    print("body--->: $requestBody");
    print("url--->: ${ApiConstant.getToken}");

    var response = await dioHelper.post(
      url: ApiConstant.getToken,
      requestBody: requestBody,
    );
    print("Response--->: $response");

    return GetTokenModel.fromJson(response);
  }

  Future<SignUpModel> signUp(Object requestBody) async {
    var response = await dioHelper.post(
      url: ApiConstant.signUp,
      requestBody: requestBody,
    );
    print("Sign Response--->: $response");
    return SignUpModel.fromJson(response);
  }

  Future<GetPartnerModel> getPartnerData(int id) async {
  //  print("url--->:${ApiConstant.getPartnerId(id)}");
    var response = await dioHelper.get(
      url: ApiConstant.getPartnerId(id),
      isAuthRequired: true,
    );
    print("---->getCustomerData--->${response.toString()}");

    return GetPartnerModel.fromJson(response);
  }

/*  Future<GetSubscriptionModel> getSubscription() async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getSubscription,
      isAuthRequired: true,
    );
    return GetSubscriptionModel.fromJson(response);
  }

  Future<ApiResponse> getSubscriptionMembership(Object requestBody) async {
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.baseUrl + ApiConstant.getSubscriptionMembership,
      isAuthRequired: true,
      requestBody: requestBody,
    );
    return ApiResponse.fromJson(response);
  }*/

  Future<FaqResponseModel> getFaq(int entityType) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getFaq(entityType),
      isAuthRequired: true,
    );
    return FaqResponseModel.fromJson(response);
  }

  Future<GuidesResponseModel> getGuides(int entityType) async {
    var response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getGuides(entityType),
      isAuthRequired: true,
    );

    return GuidesResponseModel.fromJson(response);
  }

  Future<TermsAndConditionsResponseModel> getTermsAndConditions(
      int entityType,) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getTermsAndConditions(entityType),
      isAuthRequired: true,
    );
    print("---->termcondition${response.toString()}");
    return TermsAndConditionsResponseModel.fromJson(response);
  }

  Future<GetRewardedCustomersModel> GetRewardedCustomersRepo(
      ) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.rewardedCustomer,
      isAuthRequired: true,
    );
    print("---->termcondition${response.toString()}");
    return GetRewardedCustomersModel.fromJson(response);
  }

  Future<GetRewardedCustomersModel> GetRewardedCustomersByIdRepo(
      int offerId,) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.rewardedCustomerById(offerId),
      isAuthRequired: true,
    );
    print("---->termcondition${response.toString()}");
    return GetRewardedCustomersModel.fromJson(response);
  }
 Future<GetRewardedCustomersModel> GetRewardedCustomersAlldRepo(
      ) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.rewardedCustomer,
      isAuthRequired: true,
    );
    print("---->termcondition${response.toString()}");
    return GetRewardedCustomersModel.fromJson(response);
  }





  Future<void> uploadProfilePicture(requestBody) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstant.uploadProfileImage,
        requestBody: requestBody,
        isAuthRequired: true,
      );
      print("Upload success: $response");
    } catch (e) {
      print("Upload failed: $e");
    }
  }

  Future<dynamic> uploadProfile(Object requestBody) async {
    try {
      final response = await dioHelper.put(
        url: ApiConstant.uploadProfile,
        requestBody: requestBody,
        isAuthRequired: true,
      );
      print("Save profile success: $response");
    } catch (e) {
      print("Save profile failed: $e");
    }
  }

  Future<dynamic> validateWashQrRepo(Object requestBody) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstant.validateWashQr,
        requestBody: requestBody,
        isAuthRequired: true,
      );
      print("validateWashQr success: $response");
    } catch (e) {
      print("validateWashQr failed: $e");
    }
  }

  Future<GetOfferResponseModel> getAllOffer() async {
    // print("url--->:${ApiConstant.getOffers}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffers,
      isAuthRequired: true,
    );
    // print("Response--->: $response");
    return GetOfferResponseModel.fromJson(response);
  }
  Future<GetOffersByIdModel> getOfferById(int id) async {
    // print("url--->:${ApiConstant.getOffersById}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffersById(id),
      isAuthRequired: true,
    );
    print("Response--->: $response");
    return GetOffersByIdModel.fromJson(response);
  }



  Future<GetCustomerData> getCustomerData(int id) async {
    print("url dss--->:${ApiConstant.getCustomerId(id)}");
    var response = await dioHelper.get(
      url: ApiConstant.getCustomerId(id),
      isAuthRequired: true,
    );
    print("getCustomerData response--->${response.toString()}");

    return GetCustomerData.fromJson(response);
  }
}
