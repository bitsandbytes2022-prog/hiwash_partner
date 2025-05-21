import '../../../network_manager/api_constant.dart';

class GetOfferCategoriesModel {
  bool? success;
  String? message;
  List<OfferCategory>? offerCategory;

  GetOfferCategoriesModel({this.success, this.message, this.offerCategory});

  GetOfferCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null && json['data'] is List) {
      offerCategory = (json['data'] as List)
          .map((v) => OfferCategory.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.offerCategory != null) {
      data['data'] = this.offerCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferCategory {
  int? id;
  String? name;
  String? description;
  String? image;

  OfferCategory({this.id, this.name, this.description, this.image});

  OfferCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'] != null
        ? "${ApiConstant.baseImageUrl}${json['image']}"
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
