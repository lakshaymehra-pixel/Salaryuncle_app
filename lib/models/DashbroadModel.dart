class DashbroadModel {
  int? status;
  String? message;
  Steps? steps;

  DashbroadModel({this.status, this.message, this.steps});

  DashbroadModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    steps = json['Steps'] != null ? new Steps.fromJson(json['Steps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.steps != null) {
      data['Steps'] = this.steps!.toJson();
    }
    return data;
  }
}

class Steps {
  steps? stepss;
  Data? data;
  Outstanding? outstanding;

  Steps({this.stepss, this.data, this.outstanding});

  Steps.fromJson(Map<String, dynamic> json) {
    stepss = json['steps'] != null ? new steps.fromJson(json['steps']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    outstanding = json['outstanding'] != null
        ? new Outstanding.fromJson(json['outstanding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stepss != null) {
      data['steps'] = this.stepss!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.outstanding != null) {
      data['outstanding'] = this.outstanding!.toJson();
    }
    return data;
  }
}

class steps {
  String mobileVerification = "";
  String panVerification = "";
  String personalDetails = "";
  String incomeDetails = "";
  String crAddress = "";
  String profilePic = "";
  String documentsUploads = "";
  String eligibilityStatus = "";
  String companyInfo = "";
  String loanCal = "";
  int stepStage = 0;
  int stepCompletePercent = 0;

  steps(
      {this.mobileVerification = "",
      this.panVerification = "",
      this.personalDetails = "",
      this.incomeDetails = "",
      this.crAddress = "",
      this.profilePic = "",
      this.documentsUploads = "",
      this.eligibilityStatus = "",
      this.companyInfo = "",
      this.loanCal = "",
      this.stepStage = 0,
      this.stepCompletePercent = 0});

  steps.fromJson(Map<String, dynamic> json) {
    mobileVerification = json['mobile_verification'];
    panVerification = json['pan_verification'];
    personalDetails = json['personal_details'];
    incomeDetails = json['income_details'];
    crAddress = json['cr_address'];
    profilePic = json['profile_pic'];
    documentsUploads = json['documents_uploads'];
    eligibilityStatus = json['eligibility_status'];
    companyInfo = json['company_info'];
    loanCal = json['loan_cal'];
    stepStage = json['step_stage'];
    stepCompletePercent = json['step_complete_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_verification'] = this.mobileVerification;
    data['pan_verification'] = this.panVerification;
    data['personal_details'] = this.personalDetails;
    data['income_details'] = this.incomeDetails;
    data['cr_address'] = this.crAddress;
    data['profile_pic'] = this.profilePic;
    data['documents_uploads'] = this.documentsUploads;
    data['eligibility_status'] = this.eligibilityStatus;
    data['company_info'] = this.companyInfo;
    data['loan_cal'] = this.loanCal;
    data['step_stage'] = this.stepStage;
    data['step_complete_percent'] = this.stepCompletePercent;
    return data;
  }
}

class Data {
  String shortName = "";
  String pancard = "";
  String mobile = "";
  String stateId = "";
  String cityId = "";
  String pincode = "";
  String currentHouse = "";
  String currentLocality = "";
  String currentLandmark = "";
  String currentResidenceType = "";
  String fullName = "";
  String email = "";
  String maritalStatus = "";
  String gender = "";
  String dob = "";
  String monthlySalary = "";
  String companyName = "";
  String salaryMode = "";
  String employeeType = "";
  String profilePicPath = "";
  String purpose = "";
  String tenure = "";
  String loanAmount = "";
  String ceEmail = "";
  String ceStateId = "";
  String ceCityId = "";
  String cePincode = "";
  String workMode = "";
  String address1 = "";
  String address2 = "";
  String serviceTenure = "";
  String empSince = "";
  String department = "";
  String designation = "";
  Docs? docs = Docs();

  Data(
      {this.shortName = "",
      this.pancard = "",
      this.mobile = "",
      this.stateId = "",
      this.cityId = "",
      this.pincode = "",
      this.currentHouse = "",
      this.currentLocality = "",
      this.currentLandmark = "",
      this.currentResidenceType = "",
      this.fullName = "",
      this.email = "",
      this.maritalStatus = "",
      this.gender = "",
      this.dob = "",
      this.monthlySalary = "",
      this.companyName = "",
      this.salaryMode = "",
      this.employeeType = "",
      this.profilePicPath = "",
      this.purpose = "",
      this.tenure = "",
      this.loanAmount = "",
      this.ceEmail = "",
      this.ceStateId = "",
      this.ceCityId = "",
      this.cePincode = "",
      this.workMode = "",
      this.address1 = "",
      this.address2 = "",
      this.serviceTenure = "",
      this.empSince = "",
      this.department = "",
      this.designation = "",
      this.docs});

  Data.fromJson(Map<String, dynamic> json) {
    shortName = json['short_name'] ?? "";
    pancard = json['pancard'] ?? "";
    mobile = json['mobile'] ?? "";
    stateId = json['state_id'] ?? "";
    cityId = json['city_id'] ?? "";
    pincode = json['pincode'] ?? "";
    currentHouse = json['current_house'] ?? "";
    currentLocality = json['current_locality'] ?? "";
    currentLandmark = json['current_landmark'] ?? "";
    currentResidenceType = json['current_residence_type'] ?? "";
    fullName = json['full_name'] ?? "";
    email = json['email'] ?? "";
    maritalStatus = json['marital_status'] ?? "";
    gender = json['gender'] ?? "";
    dob = json['dob'] ?? "";
    monthlySalary = json['monthly_salary'] ?? "";
    companyName = json['company_name'] ?? "";
    salaryMode = json['salary_mode'] ?? "";
    employeeType = json['employee_type'] ?? "";
    profilePicPath = json['profile_pic_path'] ?? "";
    purpose = json['purpose'] ?? "";
    tenure = json['tenure'] ?? "";
    loanAmount = json['loan_amount'] ?? "";
    ceEmail = json['ce_email'] ?? "";
    ceStateId = json['ce_state_id'] ?? "";
    ceCityId = json['ce_city_id'] ?? "";
    cePincode = json['ce_pincode'] ?? "";
    workMode = json['work_mode'] ?? "";
    address1 = json['address1'] ?? "";
    address2 = json['address2'] ?? "";
    serviceTenure = json['service_tenure'] ?? "";
    empSince = json['emp_since'] ?? "";
    department = json['department'] ?? "";
    designation = json['designation'] ?? "";
    // docs = json['docs'] != null ? new Docs.fromJson(json['docs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short_name'] = this.shortName;
    data['pancard'] = this.pancard;
    data['mobile'] = this.mobile;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['pincode'] = this.pincode;
    data['current_house'] = this.currentHouse;
    data['current_locality'] = this.currentLocality;
    data['current_landmark'] = this.currentLandmark;
    data['current_residence_type'] = this.currentResidenceType;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['marital_status'] = this.maritalStatus;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['monthly_salary'] = this.monthlySalary;
    data['company_name'] = this.companyName;
    data['salary_mode'] = this.salaryMode;
    data['employee_type'] = this.employeeType;
    data['profile_pic_path'] = this.profilePicPath;
    data['purpose'] = this.purpose;
    data['tenure'] = this.tenure;
    data['loan_amount'] = this.loanAmount;
    data['ce_email'] = this.ceEmail;
    data['ce_state_id'] = this.ceStateId;
    data['ce_city_id'] = this.ceCityId;
    data['ce_pincode'] = this.cePincode;
    data['work_mode'] = this.workMode;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['service_tenure'] = this.serviceTenure;
    data['emp_since'] = this.empSince;
    data['department'] = this.department;
    data['designation'] = this.designation;
    // if (this.docs != null) {
    //   data['docs'] = this.docs!.toJson();
    // }
    return data;
  }
}

class Docs {
  String? s1;
  String? s33;

  Docs({this.s1, this.s33});

  Docs.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s33 = json['33'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['33'] = this.s33;
    return data;
  }
}

class Outstanding {
  String? orderId;
  RepaymentData? repaymentData;

  Outstanding({this.orderId, this.repaymentData});

  Outstanding.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    repaymentData = json['repayment_data'] != null
        ? new RepaymentData.fromJson(json['repayment_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    if (this.repaymentData != null) {
      data['repayment_data'] = this.repaymentData!.toJson();
    }
    return data;
  }
}

class RepaymentData {
  String? loanNo;
  String? leadBlackListFlag;
  String? status;
  String? disbursalDate;
  String? repaymentDate;
  String? repaymentInterestDate;
  int? roi;
  int? penalRoi;
  int? tenure;
  int? realdays;
  int? penaltyDays;
  int? recoveredInterestAmountDeducted;
  int? advanceInterestAmountDeducted;
  int? repaymentAmount;
  int? realInterest;
  int? repaymentWithRealInterest;
  int? totalInterestAmount;
  int? interestDiscountAmount;
  int? totalInterestAmountReceived;
  int? totalInterestAmountPending;
  int? loanRecommended;
  int? principleDiscountAmount;
  int? totalPrincipleAmountReceived;
  int? totalPrincipleAmountPending;
  int? penaltyInterest;
  int? penaltyDiscountAmount;
  int? totalPenaltyInterestReceived;
  int? totalPenaltyInterestPending;
  int? totalRepaymentAmount;
  int? totalReceivedAmount;
  int? totalDueAmount;
  int? totalDiscountAmount;
  int? loanNocSettledLetterDatetime;
  int? loanNocSettlementLetter;
  int? loanNocClosedLetterDatetime;
  int? loanNocClosingLetter;
  int? mobile;
  String? email;

  RepaymentData(
      {this.loanNo,
      this.leadBlackListFlag,
      this.status,
      this.disbursalDate,
      this.repaymentDate,
      this.repaymentInterestDate,
      this.roi,
      this.penalRoi,
      this.tenure,
      this.realdays,
      this.penaltyDays,
      this.recoveredInterestAmountDeducted,
      this.advanceInterestAmountDeducted,
      this.repaymentAmount,
      this.realInterest,
      this.repaymentWithRealInterest,
      this.totalInterestAmount,
      this.interestDiscountAmount,
      this.totalInterestAmountReceived,
      this.totalInterestAmountPending,
      this.loanRecommended,
      this.principleDiscountAmount,
      this.totalPrincipleAmountReceived,
      this.totalPrincipleAmountPending,
      this.penaltyInterest,
      this.penaltyDiscountAmount,
      this.totalPenaltyInterestReceived,
      this.totalPenaltyInterestPending,
      this.totalRepaymentAmount,
      this.totalReceivedAmount,
      this.totalDueAmount,
      this.totalDiscountAmount,
      this.loanNocSettledLetterDatetime,
      this.loanNocSettlementLetter,
      this.loanNocClosedLetterDatetime,
      this.loanNocClosingLetter,
      this.mobile,
      this.email});

  RepaymentData.fromJson(Map<String, dynamic> json) {
    loanNo = json['loan_no'];
    leadBlackListFlag = json['lead_black_list_flag'];
    status = json['status'];
    disbursalDate = json['disbursal_date'];
    repaymentDate = json['repayment_date'];
    repaymentInterestDate = json['repayment_interest_date'];
    roi = json['roi'];
    penalRoi = json['penal_roi'];
    tenure = json['tenure'];
    realdays = json['realdays'];
    penaltyDays = json['penalty_days'];
    recoveredInterestAmountDeducted =
        json['recovered_interest_amount_deducted'];
    advanceInterestAmountDeducted = json['advance_interest_amount_deducted'];
    repaymentAmount = json['repayment_amount'];
    realInterest = json['real_interest'];
    repaymentWithRealInterest = json['repayment_with_real_interest'];
    totalInterestAmount = json['total_interest_amount'];
    interestDiscountAmount = json['interest_discount_amount'];
    totalInterestAmountReceived = json['total_interest_amount_received'];
    totalInterestAmountPending = json['total_interest_amount_pending'];
    loanRecommended = json['loan_recommended'];
    principleDiscountAmount = json['principle_discount_amount'];
    totalPrincipleAmountReceived = json['total_principle_amount_received'];
    totalPrincipleAmountPending = json['total_principle_amount_pending'];
    penaltyInterest = json['penalty_interest'];
    penaltyDiscountAmount = json['penalty_discount_amount'];
    totalPenaltyInterestReceived = json['total_penalty_interest_received'];
    totalPenaltyInterestPending = json['total_penalty_interest_pending'];
    totalRepaymentAmount = json['total_repayment_amount'];
    totalReceivedAmount = json['total_received_amount'];
    totalDueAmount = json['total_due_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    loanNocSettledLetterDatetime = json['loan_noc_settled_letter_datetime'];
    loanNocSettlementLetter = json['loan_noc_settlement_letter'];
    loanNocClosedLetterDatetime = json['loan_noc_closed_letter_datetime'];
    loanNocClosingLetter = json['loan_noc_closing_letter'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_no'] = this.loanNo;
    data['lead_black_list_flag'] = this.leadBlackListFlag;
    data['status'] = this.status;
    data['disbursal_date'] = this.disbursalDate;
    data['repayment_date'] = this.repaymentDate;
    data['repayment_interest_date'] = this.repaymentInterestDate;
    data['roi'] = this.roi;
    data['penal_roi'] = this.penalRoi;
    data['tenure'] = this.tenure;
    data['realdays'] = this.realdays;
    data['penalty_days'] = this.penaltyDays;
    data['recovered_interest_amount_deducted'] =
        this.recoveredInterestAmountDeducted;
    data['advance_interest_amount_deducted'] =
        this.advanceInterestAmountDeducted;
    data['repayment_amount'] = this.repaymentAmount;
    data['real_interest'] = this.realInterest;
    data['repayment_with_real_interest'] = this.repaymentWithRealInterest;
    data['total_interest_amount'] = this.totalInterestAmount;
    data['interest_discount_amount'] = this.interestDiscountAmount;
    data['total_interest_amount_received'] = this.totalInterestAmountReceived;
    data['total_interest_amount_pending'] = this.totalInterestAmountPending;
    data['loan_recommended'] = this.loanRecommended;
    data['principle_discount_amount'] = this.principleDiscountAmount;
    data['total_principle_amount_received'] = this.totalPrincipleAmountReceived;
    data['total_principle_amount_pending'] = this.totalPrincipleAmountPending;
    data['penalty_interest'] = this.penaltyInterest;
    data['penalty_discount_amount'] = this.penaltyDiscountAmount;
    data['total_penalty_interest_received'] = this.totalPenaltyInterestReceived;
    data['total_penalty_interest_pending'] = this.totalPenaltyInterestPending;
    data['total_repayment_amount'] = this.totalRepaymentAmount;
    data['total_received_amount'] = this.totalReceivedAmount;
    data['total_due_amount'] = this.totalDueAmount;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['loan_noc_settled_letter_datetime'] =
        this.loanNocSettledLetterDatetime;
    data['loan_noc_settlement_letter'] = this.loanNocSettlementLetter;
    data['loan_noc_closed_letter_datetime'] = this.loanNocClosedLetterDatetime;
    data['loan_noc_closing_letter'] = this.loanNocClosingLetter;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
