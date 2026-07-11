class PanCardRequest {
  String? panNumber;
  String? name;
  String? dob;
  String? panStatus;

  PanCardRequest({this.panNumber, this.name, this.dob, this.panStatus});

  PanCardRequest.fromJson(Map<String, dynamic> json) {
    panNumber = json['panNumber'];
    name = json['name'];
    dob = json['dob'];
    panStatus = json['panStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['panNumber'] = this.panNumber;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['panStatus'] = this.panStatus;
    return data;
  }
}
