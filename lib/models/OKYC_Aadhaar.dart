class OKYC_Aadhaar {
  String? aadhaarNumber;

  OKYC_Aadhaar({this.aadhaarNumber});

  OKYC_Aadhaar.fromJson(Map<String, dynamic> json) {
    aadhaarNumber = json['aadhaarNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aadhaarNumber'] = this.aadhaarNumber;
    return data;
  }
}
