
import '../../../network_manager/api_constant.dart';

class GetOfferResponseModel {
  bool? success;
  String? message;
  Data? data;

  GetOfferResponseModel({this.success, this.message, this.data});

  GetOfferResponseModel.fromJson(Map<String, dynamic> json) {
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
  Summary? summary;
  List<Offers>? offers;

  Data({this.summary, this.offers});

  Data.fromJson(Map<String, dynamic> json) {
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? totalReward;
  int? rewardedCustomers;

  Summary({this.totalReward, this.rewardedCustomers});

  Summary.fromJson(Map<String, dynamic> json) {
    totalReward = json['totalReward'];
    rewardedCustomers = json['rewardedCustomers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalReward'] = this.totalReward;
    data['rewardedCustomers'] = this.rewardedCustomers;
    return data;
  }
}

class Offers {
  int? id;
  int? partnerId;
  String? businessName;
  String? categoryName;
  String? title;
  String? description;
  String? offerDetails;
  String? howToRedeem;
  String? termsAndConditions;
  double? discountValue;
  String? expiryDate;
  String? image;
  String? qRCodeUrl;

  Offers(
      {this.id,
        this.partnerId,
        this.businessName,
        this.categoryName,
        this.title,
        this.description,
        this.offerDetails,
        this.howToRedeem,
        this.termsAndConditions,
        this.discountValue,
        this.expiryDate,
        this.image,
        this.qRCodeUrl});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partnerId = json['partnerId'];
    businessName = json['businessName'];
    categoryName = json['categoryName'];
    title = json['title'];
    description = json['description'];
    offerDetails = json['offerDetails'];
    howToRedeem = json['howToRedeem'];
    termsAndConditions = json['termsAndConditions'];
    discountValue = json['discountValue'];
    expiryDate = json['expiryDate'];
    image = json['image'] != null
        ? "${ApiConstant.baseImageUrl}${json['image']}"
        : null;
    qRCodeUrl = json['qRCodeUrl']!=null?"${ApiConstant.baseImageUrl}${json['qRCodeUrl']}":null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partnerId'] = this.partnerId;
    data['businessName'] = this.businessName;
    data['categoryName'] = this.categoryName;
    data['title'] = this.title;
    data['description'] = this.description;
    data['offerDetails'] = this.offerDetails;
    data['howToRedeem'] = this.howToRedeem;
    data['termsAndConditions'] = this.termsAndConditions;
    data['discountValue'] = this.discountValue;
    data['expiryDate'] = this.expiryDate;
    data['image'] = this.image;
    data['qRCodeUrl'] = this.qRCodeUrl;
    return data;
  }
}



