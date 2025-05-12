

import 'package:hiwash_partner/network_manager/api_constant.dart';

class GetCustomerData {
  bool? success;
  String? message;
  Data? data;

  GetCustomerData({this.success, this.message, this.data});

  GetCustomerData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CustomerDetails? customerDetails;
  SubscriptionDetails? subscriptionDetails;

  Data({this.customerDetails, this.subscriptionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    customerDetails = json['customerDetails'] != null
        ? new CustomerDetails.fromJson(json['customerDetails'])
        : null;
    subscriptionDetails = json['subscriptionDetails'] != null
        ? new SubscriptionDetails.fromJson(json['subscriptionDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerDetails != null) {
      data['customerDetails'] = this.customerDetails!.toJson();
    }
    if (this.subscriptionDetails != null) {
      data['subscriptionDetails'] = this.subscriptionDetails!.toJson();
    }
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? street;
  String? zone;
  String? building;
  String? unit;
  String? profilePicUrl;
  String? carNumber;

  CustomerDetails(
      {this.id,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.street,
        this.zone,
        this.building,
        this.unit,
        this.profilePicUrl,
        this.carNumber});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobileNumber = json['mobileNumber']??"";
    street = json['street']??"";
    zone = json['zone']??"";
    building = json['building']??"";
    unit = json['unit']??"";
    profilePicUrl =
    json['profilePicUrl'] != null
        ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}?timestamp=${DateTime.now().millisecondsSinceEpoch}"
        : null;


    carNumber = json['carNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['street'] = this.street;
    data['zone'] = this.zone;
    data['building'] = this.building;
    data['unit'] = this.unit;
    data['profilePicUrl'] = this.profilePicUrl;
    data['carNumber'] = this.carNumber;
    return data;
  }
}

class SubscriptionDetails {
  int? subscriptionId;
  String? startDate;
  String? endDate;
  String? subscriptionName;
  int? duration;
  bool? isPremium;
  double? price;
  String? currency;
  String? qrCodeUrl;
  int? totalWashes;
  String? remainingWashes;

  SubscriptionDetails(
      {this.subscriptionId,
        this.startDate,
        this.endDate,
        this.subscriptionName,
        this.duration,
        this.isPremium,
        this.price,
        this.currency,
        this.qrCodeUrl,
        this.totalWashes,
        this.remainingWashes});

  SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    subscriptionName = json['subscriptionName'];
    duration = json['duration'];
    isPremium = json['isPremium'];
    price = json['price'];
    currency = json['currency'];
    qrCodeUrl = json['qrCodeUrl']!=null?"${ApiConstant.baseImageUrl}${json['qrCodeUrl']}":null;
    totalWashes = json['totalWashes'];
    remainingWashes = json['remainingWashes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionId'] = this.subscriptionId.toString();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['subscriptionName'] = this.subscriptionName;
    data['duration'] = this.duration.toString();
    data['isPremium'] = this.isPremium;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['qrCodeUrl'] = this.qrCodeUrl;
    data['totalWashes'] = this.totalWashes.toString();
    data['remainingWashes'] = this.remainingWashes;
    return data;
  }
}


/*
import '../../../network_manager/api_constant.dart';

class GetCustomerData {
  bool? success;
  String? message;
  Data? data;

  GetCustomerData({this.success, this.message, this.data});

  GetCustomerData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CustomerDetails? customerDetails;
  SubscriptionDetails? subscriptionDetails;

  Data({this.customerDetails, this.subscriptionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    customerDetails =
        json['customerDetails'] != null
            ? new CustomerDetails.fromJson(json['customerDetails'])
            : null;
    subscriptionDetails =
        json['subscriptionDetails'] != null
            ? new SubscriptionDetails.fromJson(json['subscriptionDetails'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerDetails != null) {
      data['customerDetails'] = this.customerDetails!.toJson();
    }
    if (this.subscriptionDetails != null) {
      data['subscriptionDetails'] = this.subscriptionDetails!.toJson();
    }
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? street;
  String? zone;
  String? building;
  String? unit;
  String? profilePicUrl;
  String? carNumber;

  CustomerDetails({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.street,
    this.zone,
    this.building,
    this.unit,
    this.profilePicUrl,
    this.carNumber,
  });

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    street = json['street'];
    zone = json['zone'];
    building = json['building'];
    unit = json['unit'];
    profilePicUrl =
        json['profilePicUrl'] != null
            ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}"
            : null;

    carNumber = json['carNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['street'] = this.street;
    data['zone'] = this.zone;
    data['building'] = this.building;
    data['unit'] = this.unit;
    data['profilePicUrl'] = this.profilePicUrl;
    data['carNumber'] = this.carNumber;
    return data;
  }
}

class SubscriptionDetails {
  int? subscriptionId;
  String? startDate;
  String? endDate;
  String? subscriptionName;
  int? duration;
  bool? isPremium;
  double? price;
  String? currency;
  String? qrCodeUrl;

  SubscriptionDetails({
    this.subscriptionId,
    this.startDate,
    this.endDate,
    this.subscriptionName,
    this.duration,
    this.isPremium,
    this.price,
    this.currency,
    this.qrCodeUrl,
  });

  SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    subscriptionName = json['subscriptionName'];
    duration = json['duration'];
    isPremium = json['isPremium'];
    price = json['price'];
    currency = json['currency'];
    qrCodeUrl = json['qrCodeUrl']!=null?"${ApiConstant.baseImageUrl}${json['qrCodeUrl']}":null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionId'] = this.subscriptionId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['subscriptionName'] = this.subscriptionName;
    data['duration'] = this.duration.toString();
    data['isPremium'] = this.isPremium;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['qrCodeUrl'] = this.qrCodeUrl;
    return data;
  }
}
*/
