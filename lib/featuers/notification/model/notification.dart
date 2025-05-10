class NotificationModel {
  bool? success;
  String? message;
  List<Data>? data;

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  bool? isRead;
  String? readAt;
  int? notificationType;
  String? createdAt;

  Data(
      {this.id,
        this.message,
        this.isRead,
        this.readAt,
        this.notificationType,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    isRead = json['isRead'];
    readAt = json['readAt'];
    notificationType = json['notificationType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['isRead'] = this.isRead;
    data['readAt'] = this.readAt;
    data['notificationType'] = this.notificationType;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
