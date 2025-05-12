import '../../../network_manager/api_constant.dart';

class GetOffersByIdModel {
  bool? success;
  String? message;
  List<OfferDetailList>? offerDetailList;

  GetOffersByIdModel({this.success, this.message, this.offerDetailList});

  GetOffersByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      offerDetailList = <OfferDetailList>[];
      json['data'].forEach((v) {
        offerDetailList!.add(new OfferDetailList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.offerDetailList != null) {
      data['data'] = this.offerDetailList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferDetailList {
  int? id;
  String? businessName;
  String? businessImageUrl;
  String? businessAddress;
  String? categoryName;
  String? title;
  String? description;
  String? offerDetails;
  String? howToRedeem;
  String? termsAndConditions;
  double? discountValue;
  String? expiryDate;
  String? image;
  String? bannerImageUrl;
  String? qRCodeUrl;

  OfferDetailList({
    this.id,
    this.businessName,
    this.businessImageUrl,
    this.businessAddress,
    this.categoryName,
    this.title,
    this.description,
    this.offerDetails,
    this.howToRedeem,
    this.termsAndConditions,
    this.discountValue,
    this.expiryDate,
    this.image,
    this.bannerImageUrl,
    this.qRCodeUrl,
  });

  OfferDetailList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    businessImageUrl = json['businessImageUrl'];
    businessAddress = json['businessAddress'];
    categoryName = json['categoryName'];
    title = json['title'];
    description = json['description'];
    offerDetails = json['offerDetails'];
    howToRedeem = json['howToRedeem'];
    termsAndConditions = json['termsAndConditions'];
    discountValue = json['discountValue'];
    expiryDate = json['expiryDate'];
    image =
        json['image'] != null
            ? "${ApiConstant.baseImageUrl}${json['image']}"
            : null;
    bannerImageUrl =
        json['bannerImageUrl'] != null
            ? "${ApiConstant.baseImageUrl}${json['bannerImageUrl']}?timestamp=${DateTime.now().millisecondsSinceEpoch}"
            : null;
    qRCodeUrl =
        json['qRCodeUrl'] != null
            ? "${ApiConstant.baseImageUrl}${json['qRCodeUrl']}"
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['businessImageUrl'] = this.businessImageUrl;
    data['businessAddress'] = this.businessAddress;
    data['categoryName'] = this.categoryName;
    data['title'] = this.title;
    data['description'] = this.description;
    data['offerDetails'] = this.offerDetails;
    data['howToRedeem'] = this.howToRedeem;
    data['termsAndConditions'] = this.termsAndConditions;
    data['discountValue'] = this.discountValue;
    data['expiryDate'] = this.expiryDate;
    data['image'] = this.image;
    data['bannerImageUrl'] = this.bannerImageUrl;
    data['qRCodeUrl'] = this.qRCodeUrl;
    return data;
  }
}


