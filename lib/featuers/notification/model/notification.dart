class NotificationModel {
  bool? success;
  String? message;
  List<NotificationData>? notificationData;

  NotificationModel({this.success, this.message, this.notificationData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      notificationData = <NotificationData>[];
      json['data'].forEach((v) {
        notificationData!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notificationData != null) {
      data['data'] = this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  String? message;
  bool? isRead;
  String? readAt;
  int? notificationType;
  String? createdAt;

  NotificationData(
      {this.id,
        this.message,
        this.isRead,
        this.readAt,
        this.notificationType,
        this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
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
