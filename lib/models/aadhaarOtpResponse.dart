class GetAadhaarOTP_Responsse {
  Data? data;
  int? statusCode;
  String? message;

  GetAadhaarOTP_Responsse({this.data, this.statusCode, this.message});

  GetAadhaarOTP_Responsse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? requestId;
  bool? otpSentStatus;
  bool? ifNumber;
  bool? isValidAadhaar;
  String? status;

  Data(
      {this.requestId,
      this.otpSentStatus,
      this.ifNumber,
      this.isValidAadhaar,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    otpSentStatus = json['otpSentStatus'];
    ifNumber = json['if_number'];
    isValidAadhaar = json['isValidAadhaar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['otpSentStatus'] = this.otpSentStatus;
    data['if_number'] = this.ifNumber;
    data['isValidAadhaar'] = this.isValidAadhaar;
    data['status'] = this.status;
    return data;
  }
}
