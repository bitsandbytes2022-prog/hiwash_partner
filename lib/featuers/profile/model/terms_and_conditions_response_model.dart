class TermsAndConditionsResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  TermsAndConditionsResponseModel({this.success, this.message, this.data});

  TermsAndConditionsResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? content;
  String? versionNumber;
  String? publishedDate;
  String? createdAt;
  String? modifyAt;

  Data({
    this.id,
    this.title,
    this.content,
    this.versionNumber,
    this.publishedDate,
    this.createdAt,
    this.modifyAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    versionNumber = json['versionNumber'];
    publishedDate = json['publishedDate'];
    createdAt = json['createdAt'];
    modifyAt = (json['modifyAt'] ?? "").toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['versionNumber'] = this.versionNumber;
    data['publishedDate'] = this.publishedDate;
    data['createdAt'] = this.createdAt;
    data['modifyAt'] = this.modifyAt;
    return data;
  }
}
