class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? email;
  String? businessName;
  String? mobileNumber;
  String? token;
  String? refreshToken;

  Data(
      {this.id,
        this.email,
        this.businessName,
        this.mobileNumber,
        this.token,
        this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    businessName = json['businessName'];
    mobileNumber = json['mobileNumber'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['businessName'] = this.businessName;
    data['mobileNumber'] = this.mobileNumber;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}



/*
class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? email;
  String? businessName;
  String? mobileNumber;
  String? token;

  Data({this.id, this.email, this.businessName, this.mobileNumber, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    businessName = json['businessName'];
    mobileNumber = json['mobileNumber'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['businessName'] = this.businessName;
    data['mobileNumber'] = this.mobileNumber;
    data['token'] = this.token;
    return data;
  }
}
*/
