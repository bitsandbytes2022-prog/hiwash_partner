class SendOtpModel {
  bool? success;
  String? message;
  Data? data;

  SendOtpModel({this.success, this.message, this.data});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
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
  int? otp;
  String? otpExpiredDate;
  String? mobileNumber;

  Data({this.otp, this.otpExpiredDate, this.mobileNumber});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    otpExpiredDate = json['otpExpiredDate'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp.toString();
    data['otpExpiredDate'] = this.otpExpiredDate;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}
