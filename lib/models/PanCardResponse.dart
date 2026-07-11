class PanCardResponse {
  Result? result;

  PanCardResponse({this.result});

  PanCardResponse.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? nameMatch;
  String? panStatus;
  String? panStatusCode;
  String? dobMatch;

  Result({this.nameMatch, this.panStatus, this.panStatusCode, this.dobMatch});

  Result.fromJson(Map<String, dynamic> json) {
    nameMatch = json['nameMatch'];
    panStatus = json['panStatus'];
    panStatusCode = json['panStatusCode'];
    dobMatch = json['dobMatch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameMatch'] = this.nameMatch;
    data['panStatus'] = this.panStatus;
    data['panStatusCode'] = this.panStatusCode;
    data['dobMatch'] = this.dobMatch;
    return data;
  }
}
