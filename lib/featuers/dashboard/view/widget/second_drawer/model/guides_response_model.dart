class GuidesResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  GuidesResponseModel({this.success, this.message, this.data});

  GuidesResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? category;
  String? description;
  String? createdAt;
  String? modifyAt;

  Data({
    this.id,
    this.category,
    this.description,
    this.createdAt,
    this.modifyAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    description = json['description'];
    createdAt = json['createdAt'];
    modifyAt = json['modifyAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['modifyAt'] = this.modifyAt;
    return data;
  }
}
