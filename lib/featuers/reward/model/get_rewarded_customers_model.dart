import '../../../network_manager/api_constant.dart';

class GetRewardedCustomersModel {
  bool? success;
  String? message;
  List<GetRewardedCustomersData>? getRewardedCustomersData;

  GetRewardedCustomersModel({this.success, this.message, this.getRewardedCustomersData});

  GetRewardedCustomersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      getRewardedCustomersData = <GetRewardedCustomersData>[];
      json['data'].forEach((v) {
        getRewardedCustomersData!.add(new GetRewardedCustomersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.getRewardedCustomersData != null) {
      data['data'] = this.getRewardedCustomersData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetRewardedCustomersData {
  int? customerId;
  String? customerName;
  String? profilePicUrl;
  String? offerTitle;
  String? redeemedAt;
  int? isPremium;

  GetRewardedCustomersData(
      {this.customerId,
        this.customerName,
        this.profilePicUrl,
        this.offerTitle,
        this.redeemedAt,
        this.isPremium});

  GetRewardedCustomersData.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerName = json['customerName'];
    profilePicUrl =
    json['profilePicUrl'] != null
        ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}"
        : null;
  /*  profilePicUrl = json['profilePicUrl'];*/
    offerTitle = json['offerTitle'];
    redeemedAt = json['redeemedAt'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['offerTitle'] = this.offerTitle;
    data['redeemedAt'] = this.redeemedAt;
    data['isPremium'] = this.isPremium;
    return data;
  }
}


/*
class GetRewardedCustomersModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetRewardedCustomersModel({this.success, this.message, this.data});

  GetRewardedCustomersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? customerId;
  String? customerName;
  String? profilePicUrl;
  String? offerTitle;
  String? redeemedAt;
  int? isPremium;

  Data(
      {this.customerId,
        this.customerName,
        this.profilePicUrl,
        this.offerTitle,
        this.redeemedAt,
        this.isPremium});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];

    customerName = json['customerName'];
    profilePicUrl =
    json['profilePicUrl'] != null
        ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}"
        : null;
    offerTitle = json['offerTitle'];
    redeemedAt = json['redeemedAt'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['offerTitle'] = this.offerTitle;
    data['redeemedAt'] = this.redeemedAt;
    data['isPremium'] = this.isPremium;
    return data;
  }
}
*/
