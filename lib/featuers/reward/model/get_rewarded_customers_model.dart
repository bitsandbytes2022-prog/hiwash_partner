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
  String? mobile;
  String? offerTitle;
  String? redeemedAt;
  String? transactionId;
  String? voucherNumber;
  dynamic rating;
  dynamic comment;
  bool? isPremium;

  GetRewardedCustomersData(
      {this.customerId,
        this.customerName,
        this.profilePicUrl,
        this.mobile,
        this.offerTitle,
        this.redeemedAt,
        this.transactionId,
        this.voucherNumber,
        this.rating,
        this.comment,
        this.isPremium});

  GetRewardedCustomersData.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerName = json['customerName'];
    /*profilePicUrl = json['profilePicUrl'];*/
    profilePicUrl =
    json['profilePicUrl'] != null
        ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}"
        : null;
    mobile = json['mobile'];
    offerTitle = json['offerTitle'];
    redeemedAt = json['redeemedAt'];
    transactionId = json['transactionId'];
    voucherNumber = json['voucherNumber'];
    rating = json['rating'];
    comment = json['comment'];
    isPremium = json['isPremium'] == 1;
/*    isPremium = json['isPremium'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['mobile'] = this.mobile;
    data['offerTitle'] = this.offerTitle;
    data['redeemedAt'] = this.redeemedAt;
    data['transactionId'] = this.transactionId;
    data['voucherNumber'] = this.voucherNumber;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['isPremium'] = this.isPremium;
    return data;
  }
}


/*class GetRewardedCustomersModel {
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
  String? transactionId;
  String? voucherNumber;
  dynamic rating;
  dynamic comment;
  bool? isPremium;

  GetRewardedCustomersData(
      {this.customerId,
        this.customerName,
        this.profilePicUrl,
        this.offerTitle,
        this.redeemedAt,
        this.transactionId,
        this.voucherNumber,
        this.rating,
        this.comment,
        this.isPremium});

  GetRewardedCustomersData.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerName = json['customerName'];
    profilePicUrl =
    json['profilePicUrl'] != null
        ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}"
        : null;
   *//* profilePicUrl = json['profilePicUrl'];*//*
    offerTitle = json['offerTitle'];
    redeemedAt = json['redeemedAt'];
    transactionId = json['transactionId'];
    voucherNumber = json['voucherNumber'];
    rating = json['rating'];
    comment = json['comment'];
    isPremium = json['isPremium'] == 1;
   // isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['offerTitle'] = this.offerTitle;
    data['redeemedAt'] = this.redeemedAt;
    data['transactionId'] = this.transactionId;
    data['voucherNumber'] = this.voucherNumber;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['isPremium'] = this.isPremium;
    return data;
  }
}*/


