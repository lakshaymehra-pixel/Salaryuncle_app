class BankErrorResponse {
  Error? error;

  BankErrorResponse({this.error});

  BankErrorResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  String? name;
  String? message;
  String? reason;
  String? type;
  int? statusCode;

  Error({this.name, this.message, this.reason, this.type, this.statusCode});

  Error.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    reason = json['reason'];
    type = json['type'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    data['reason'] = this.reason;
    data['type'] = this.type;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
