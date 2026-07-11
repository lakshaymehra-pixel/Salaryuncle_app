class VerifyOtpResponse {
  int? status;
  int? flag;
  String? message;
  int? leadId;
  List<AllLeads>? allLeads;

  VerifyOtpResponse({this.status, this.flag, this.message, this.leadId, this.allLeads});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    flag = json['flag'];
    message = json['Message'];
    leadId = json['lead_id'];
    if (json['allLeads'] != null) {
      allLeads = <AllLeads>[];
      json['allLeads'].forEach((v) {
        allLeads!.add(new AllLeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['flag'] = this.flag;
    data['Message'] = this.message;
    data['lead_id'] = this.leadId;
    if (this.allLeads != null) {
      data['allLeads'] = this.allLeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllLeads {
  String? leadId;
  String? loanNo;
  String? tenure;
  String? loanAmount;
  String? monthlySalaryAmount;
  String? pincode;
  String? application_no;
  String? status;
  String? leadEntryDate;

  AllLeads(
      {this.leadId,
      this.loanNo,
      this.loanAmount,
      this.monthlySalaryAmount,
      this.pincode,
      this.status,
      this.tenure,
      this.application_no,
      this.leadEntryDate});

  AllLeads.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    loanNo = json['loan_no'];
    tenure = json['tenure'];
    loanAmount = json['loan_amount'];
    monthlySalaryAmount = json['monthly_salary_amount'];
    pincode = json['pincode'];
    status = json['status'];
    application_no = json['application_no'];
    leadEntryDate = json['lead_entry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['loan_no'] = this.loanNo;
    data['loan_amount'] = this.loanAmount;
    data['monthly_salary_amount'] = this.monthlySalaryAmount;
    data['pincode'] = this.pincode;
    data['tenure'] = this.tenure;
    data['application_no'] = this.application_no;
    data['status'] = this.status;
    data['lead_entry_date'] = this.leadEntryDate;
    return data;
  }
}
