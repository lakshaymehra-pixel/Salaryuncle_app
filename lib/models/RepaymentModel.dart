class RepaymentModel {
  String? id;
  String? leadId;
  String? loanNo;
  String? paymentMode;
  String? receivedAmount;
  String? status_name;
  String? discount;
  String? dateOfRecived;
  String? repaymentType;
  String? paymentVerification;

  RepaymentModel(
      {this.id,
      this.leadId,
      this.loanNo,
      this.paymentMode,
      this.receivedAmount,
      this.status_name,
      this.discount,
      this.dateOfRecived,
      this.repaymentType,
      this.paymentVerification});

  RepaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['lead_id'];
    loanNo = json['loan_no'];
    paymentMode = json['payment_mode'];
    receivedAmount = json['received_amount'];
    dateOfRecived = json['date_of_recived'];
    discount = json['discount'];
    status_name = json['status_name'];
    repaymentType = json['repayment_type'];
    paymentVerification = json['payment_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead_id'] = this.leadId;
    data['loan_no'] = this.loanNo;
    data['payment_mode'] = this.paymentMode;
    data['received_amount'] = this.receivedAmount;
    data['date_of_recived'] = this.dateOfRecived;
    data['discount'] = this.discount;
    data['status_name'] = this.status_name;
    data['repayment_type'] = this.repaymentType;
    data['payment_verification'] = this.paymentVerification;
    return data;
  }
}
