import 'package:hiwash_partner/network_manager/api_constant.dart';

class GetPartnerModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetPartnerModel({this.success, this.message, this.data});

  GetPartnerModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? businessName;
  String? email;
  String? mobileNumber;
  String? address;
  String? profilePicUrl;

  Data({
    this.id,
    this.businessName,
    this.email,
    this.mobileNumber,
    this.address,
    this.profilePicUrl,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    profilePicUrl =
        json['profilePicUrl'] != null
            ? "${ApiConstant.baseImageUrl}${json['profilePicUrl']}"
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['profilePicUrl'] = this.profilePicUrl;
    return data;
  }
}
