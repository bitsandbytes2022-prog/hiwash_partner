class GetTokenModel {
  bool? success;
  String? message;
  Data? data;

  GetTokenModel({this.success, this.message, this.data});

  GetTokenModel.fromJson(Map<String, dynamic> json) {
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
  int? serialNo;
  int? employeeId;
  String? firstName;
  String? lastName;
  int? positionId;
  int? locationId;
  String? mobileNumber;
  String? token;

  Data(
      {this.id,
        this.serialNo,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.positionId,
        this.locationId,
        this.mobileNumber,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serialNo'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    positionId = json['positionId'];
    locationId = json['locationId'];
    mobileNumber = json['mobileNumber'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serialNo'] = this.serialNo;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['positionId'] = this.positionId;
    data['locationId'] = this.locationId;
    data['mobileNumber'] = this.mobileNumber;
    data['token'] = this.token;
    return data;
  }
}
