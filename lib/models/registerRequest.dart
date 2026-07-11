class RegisterRequest {
  String? cityId;
  String? coordinates;
  String? email;
  String? fcmToken;
  String? firstName;
  String? incomeType;
  String? leadMobileAndroidId;
  String? loanAmount;
  String? mobile;
  String? monthlySalary;
  String? pancard;
  String? purposeofloan;
  String? utmCampaign;
  String? utmSource;

  RegisterRequest(
      {this.cityId,
      this.coordinates,
      this.email,
      this.fcmToken,
      this.firstName,
      this.incomeType,
      this.leadMobileAndroidId,
      this.loanAmount,
      this.mobile,
      this.monthlySalary,
      this.pancard,
      this.purposeofloan,
      this.utmCampaign,
      this.utmSource});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    coordinates = json['coordinates'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    firstName = json['first_name'];
    incomeType = json['income_type'];
    leadMobileAndroidId = json['lead_mobile_android_id'];
    loanAmount = json['loan_amount'];
    mobile = json['mobile'];
    monthlySalary = json['monthly_salary'];
    pancard = json['pancard'];
    purposeofloan = json['purposeofloan'];
    utmCampaign = json['utm_campaign'];
    utmSource = json['utm_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['coordinates'] = this.coordinates;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['first_name'] = this.firstName;
    data['income_type'] = this.incomeType;
    data['lead_mobile_android_id'] = this.leadMobileAndroidId;
    data['loan_amount'] = this.loanAmount;
    data['mobile'] = this.mobile;
    data['monthly_salary'] = this.monthlySalary;
    data['pancard'] = this.pancard;
    data['purposeofloan'] = this.purposeofloan;
    data['utm_campaign'] = this.utmCampaign;
    data['utm_source'] = this.utmSource;
    return data;
  }
}
