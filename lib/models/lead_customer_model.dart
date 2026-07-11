class LeadCustomerModel {
  int? status;
  var message;
  List<Data>? data;
  List<Collection>? collection;

  LeadCustomerModel({this.status, this.message, this.data, this.collection});

  LeadCustomerModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var leadId;
  var loanNo;
  var customerId;
  var applicationNo;
  var leadReferenceNo;
  var monthlySalaryAmount;
  var leadDataSourceId;
  var firstName;
  var middleName;
  var surName;
  var custFullName;
  var checkCibilStatus;
  var email;
  var alternateEmail;
  var gender;
  var mobile;
  var alternateMobile;
  var obligations;
  var promocode;
  var purpose;
  var leadStpFlag;
  var leadFinalDisbursedDate;
  var userType;
  var pancard;
  var loanAmount;
  var tenure;
  var cibil;
  var incomeType;
  var salaryMode;
  var monthlyIncome;
  var source;
  var utmSource;
  var utmCampaign;
  var dob;
  var stateId;
  var cityId;
  var leadBranchId;
  var mStateName;
  var mCityName;
  var pincode;
  var status;
  var stage;
  var leadStatusId;
  var scheduleTime;
  var createdOn;
  var coordinates;
  var ip;
  var imeiNo;
  var termAndCondition;
  var applicationStatus;
  var leadFiResidenceStatusId;
  var leadFiOfficeStatusId;
  var scheduledDate;
  var sanctionedAmount;
  var repaymentAmount;
  var disbursalDate;
  var leadCreditAssignUserId;
  var leadScreenerAssignUserId;
  var leadDisbursalAssignUserId;
  var screenedOn;
  var sanctionedOn;
  var loanStatusId;
  var leadDisbursalApproveDatetime;
  var loanDisbursementTransStatusId;
  var customerReligionId;
  var religionName;
  var mBranchName;
  var customerSpouseName;
  var customerSpouseOccupationId;
  var customerQualificationId;
  var currentResidenceType;
  var fatherName;
  var pancardVerifiedStatus;
  var customerDigitalEkycFlag;
  var alternateEmailVerifiedStatus;
  var customerAppointmentSchedule;
  var customerAppointmentRemark;
  var leadRejectedAssignUserId;
  var leadRejectedReasonId;
  var leadRejectedAssignCounter;
  var customerBreRunFlag;
  var cityCategory;
  var maritalStatus;
  var occupation;
  var qualification;

  Data(
      {this.leadId,
      this.loanNo,
      this.customerId,
      this.applicationNo,
      this.leadReferenceNo,
      this.monthlySalaryAmount,
      this.leadDataSourceId,
      this.firstName,
      this.middleName,
      this.surName,
      this.custFullName,
      this.checkCibilStatus,
      this.email,
      this.alternateEmail,
      this.gender,
      this.mobile,
      this.alternateMobile,
      this.obligations,
      this.promocode,
      this.purpose,
      this.leadStpFlag,
      this.leadFinalDisbursedDate,
      this.userType,
      this.pancard,
      this.loanAmount,
      this.tenure,
      this.cibil,
      this.incomeType,
      this.salaryMode,
      this.monthlyIncome,
      this.source,
      this.utmSource,
      this.utmCampaign,
      this.dob,
      this.stateId,
      this.cityId,
      this.leadBranchId,
      this.mStateName,
      this.mCityName,
      this.pincode,
      this.status,
      this.stage,
      this.leadStatusId,
      this.scheduleTime,
      this.createdOn,
      this.coordinates,
      this.ip,
      this.imeiNo,
      this.termAndCondition,
      this.applicationStatus,
      this.leadFiResidenceStatusId,
      this.leadFiOfficeStatusId,
      this.scheduledDate,
      this.sanctionedAmount,
      this.repaymentAmount,
      this.disbursalDate,
      this.leadCreditAssignUserId,
      this.leadScreenerAssignUserId,
      this.leadDisbursalAssignUserId,
      this.screenedOn,
      this.sanctionedOn,
      this.loanStatusId,
      this.leadDisbursalApproveDatetime,
      this.loanDisbursementTransStatusId,
      this.customerReligionId,
      this.religionName,
      this.mBranchName,
      this.customerSpouseName,
      this.customerSpouseOccupationId,
      this.customerQualificationId,
      this.currentResidenceType,
      this.fatherName,
      this.pancardVerifiedStatus,
      this.customerDigitalEkycFlag,
      this.alternateEmailVerifiedStatus,
      this.customerAppointmentSchedule,
      this.customerAppointmentRemark,
      this.leadRejectedAssignUserId,
      this.leadRejectedReasonId,
      this.leadRejectedAssignCounter,
      this.customerBreRunFlag,
      this.cityCategory,
      this.maritalStatus,
      this.occupation,
      this.qualification});

  Data.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    loanNo = json['loan_no'];
    customerId = json['customer_id'];
    applicationNo = json['application_no'];
    leadReferenceNo = json['lead_reference_no'];
    monthlySalaryAmount = json['monthly_salary_amount'];
    leadDataSourceId = json['lead_data_source_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    surName = json['sur_name'];
    custFullName = json['cust_full_name'];
    checkCibilStatus = json['check_cibil_status'];
    email = json['email'];
    alternateEmail = json['alternate_email'];
    gender = json['gender'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    obligations = json['obligations'];
    promocode = json['promocode'];
    purpose = json['purpose'];
    leadStpFlag = json['lead_stp_flag'];
    leadFinalDisbursedDate = json['lead_final_disbursed_date'];
    userType = json['user_type'];
    pancard = json['pancard'];
    loanAmount = json['loan_amount'];
    tenure = json['tenure'];
    cibil = json['cibil'];
    incomeType = json['income_type'];
    salaryMode = json['salary_mode'];
    monthlyIncome = json['monthly_income'];
    source = json['source'];
    utmSource = json['utm_source'];
    utmCampaign = json['utm_campaign'];
    dob = json['dob'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    leadBranchId = json['lead_branch_id'];
    mStateName = json['m_state_name'];
    mCityName = json['m_city_name'];
    pincode = json['pincode'];
    status = json['status'];
    stage = json['stage'];
    leadStatusId = json['lead_status_id'];
    scheduleTime = json['schedule_time'];
    createdOn = json['created_on'];
    coordinates = json['coordinates'];
    ip = json['ip'];
    imeiNo = json['imei_no'];
    termAndCondition = json['term_and_condition'];
    applicationStatus = json['application_status'];
    leadFiResidenceStatusId = json['lead_fi_residence_status_id'];
    leadFiOfficeStatusId = json['lead_fi_office_status_id'];
    scheduledDate = json['scheduled_date'];
    sanctionedAmount = json['sanctionedAmount'];
    repaymentAmount = json['repayment_amount'];
    disbursalDate = json['disbursal_date'];
    leadCreditAssignUserId = json['lead_credit_assign_user_id'];
    leadScreenerAssignUserId = json['lead_screener_assign_user_id'];
    leadDisbursalAssignUserId = json['lead_disbursal_assign_user_id'];
    screenedOn = json['screenedOn'];
    sanctionedOn = json['sanctionedOn'];
    loanStatusId = json['loan_status_id'];
    leadDisbursalApproveDatetime = json['lead_disbursal_approve_datetime'];
    loanDisbursementTransStatusId = json['loan_disbursement_trans_status_id'];
    customerReligionId = json['customer_religion_id'];
    religionName = json['religion_name'];
    mBranchName = json['m_branch_name'];
    customerSpouseName = json['customer_spouse_name'];
    customerSpouseOccupationId = json['customer_spouse_occupation_id'];
    customerQualificationId = json['customer_qualification_id'];
    currentResidenceType = json['current_residence_type'];
    fatherName = json['father_name'];
    pancardVerifiedStatus = json['pancard_verified_status'];
    customerDigitalEkycFlag = json['customer_digital_ekyc_flag'];
    alternateEmailVerifiedStatus = json['alternate_email_verified_status'];
    customerAppointmentSchedule = json['customer_appointment_schedule'];
    customerAppointmentRemark = json['customer_appointment_remark'];
    leadRejectedAssignUserId = json['lead_rejected_assign_user_id'];
    leadRejectedReasonId = json['lead_rejected_reason_id'];
    leadRejectedAssignCounter = json['lead_rejected_assign_counter'];
    customerBreRunFlag = json['customer_bre_run_flag'];
    cityCategory = json['city_category'];
    maritalStatus = json['marital_status'];
    occupation = json['occupation'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['loan_no'] = this.loanNo;
    data['customer_id'] = this.customerId;
    data['application_no'] = this.applicationNo;
    data['lead_reference_no'] = this.leadReferenceNo;
    data['monthly_salary_amount'] = this.monthlySalaryAmount;
    data['lead_data_source_id'] = this.leadDataSourceId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['sur_name'] = this.surName;
    data['cust_full_name'] = this.custFullName;
    data['check_cibil_status'] = this.checkCibilStatus;
    data['email'] = this.email;
    data['alternate_email'] = this.alternateEmail;
    data['gender'] = this.gender;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['obligations'] = this.obligations;
    data['promocode'] = this.promocode;
    data['purpose'] = this.purpose;
    data['lead_stp_flag'] = this.leadStpFlag;
    data['lead_final_disbursed_date'] = this.leadFinalDisbursedDate;
    data['user_type'] = this.userType;
    data['pancard'] = this.pancard;
    data['loan_amount'] = this.loanAmount;
    data['tenure'] = this.tenure;
    data['cibil'] = this.cibil;
    data['income_type'] = this.incomeType;
    data['salary_mode'] = this.salaryMode;
    data['monthly_income'] = this.monthlyIncome;
    data['source'] = this.source;
    data['utm_source'] = this.utmSource;
    data['utm_campaign'] = this.utmCampaign;
    data['dob'] = this.dob;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['lead_branch_id'] = this.leadBranchId;
    data['m_state_name'] = this.mStateName;
    data['m_city_name'] = this.mCityName;
    data['pincode'] = this.pincode;
    data['status'] = this.status;
    data['stage'] = this.stage;
    data['lead_status_id'] = this.leadStatusId;
    data['schedule_time'] = this.scheduleTime;
    data['created_on'] = this.createdOn;
    data['coordinates'] = this.coordinates;
    data['ip'] = this.ip;
    data['imei_no'] = this.imeiNo;
    data['term_and_condition'] = this.termAndCondition;
    data['application_status'] = this.applicationStatus;
    data['lead_fi_residence_status_id'] = this.leadFiResidenceStatusId;
    data['lead_fi_office_status_id'] = this.leadFiOfficeStatusId;
    data['scheduled_date'] = this.scheduledDate;
    data['sanctionedAmount'] = this.sanctionedAmount;
    data['repayment_amount'] = this.repaymentAmount;
    data['disbursal_date'] = this.disbursalDate;
    data['lead_credit_assign_user_id'] = this.leadCreditAssignUserId;
    data['lead_screener_assign_user_id'] = this.leadScreenerAssignUserId;
    data['lead_disbursal_assign_user_id'] = this.leadDisbursalAssignUserId;
    data['screenedOn'] = this.screenedOn;
    data['sanctionedOn'] = this.sanctionedOn;
    data['loan_status_id'] = this.loanStatusId;
    data['lead_disbursal_approve_datetime'] = this.leadDisbursalApproveDatetime;
    data['loan_disbursement_trans_status_id'] =
        this.loanDisbursementTransStatusId;
    data['customer_religion_id'] = this.customerReligionId;
    data['religion_name'] = this.religionName;
    data['m_branch_name'] = this.mBranchName;
    data['customer_spouse_name'] = this.customerSpouseName;
    data['customer_spouse_occupation_id'] = this.customerSpouseOccupationId;
    data['customer_qualification_id'] = this.customerQualificationId;
    data['current_residence_type'] = this.currentResidenceType;
    data['father_name'] = this.fatherName;
    data['pancard_verified_status'] = this.pancardVerifiedStatus;
    data['customer_digital_ekyc_flag'] = this.customerDigitalEkycFlag;
    data['alternate_email_verified_status'] = this.alternateEmailVerifiedStatus;
    data['customer_appointment_schedule'] = this.customerAppointmentSchedule;
    data['customer_appointment_remark'] = this.customerAppointmentRemark;
    data['lead_rejected_assign_user_id'] = this.leadRejectedAssignUserId;
    data['lead_rejected_reason_id'] = this.leadRejectedReasonId;
    data['lead_rejected_assign_counter'] = this.leadRejectedAssignCounter;
    data['customer_bre_run_flag'] = this.customerBreRunFlag;
    data['city_category'] = this.cityCategory;
    data['marital_status'] = this.maritalStatus;
    data['occupation'] = this.occupation;
    data['qualification'] = this.qualification;
    return data;
  }
}

class Collection {
  var receivedAmount;
  var dateOfRecived;
  var remarks;

  Collection({this.receivedAmount, this.dateOfRecived, this.remarks});

  Collection.fromJson(Map<String, dynamic> json) {
    receivedAmount = json['received_amount'];
    dateOfRecived = json['date_of_recived'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['received_amount'] = this.receivedAmount;
    data['date_of_recived'] = this.dateOfRecived;
    data['remarks'] = this.remarks;
    return data;
  }
}
