class BankVerifyRequest {
  String? beneficiaryAccount;
  String? beneficiaryIFSC;
  String? beneficiaryMobile;
  String? beneficiaryName;
  String? nameFuzzy;
  String? nameMatchScore;

  BankVerifyRequest(
      {this.beneficiaryAccount,
      this.beneficiaryIFSC,
      this.beneficiaryMobile,
      this.beneficiaryName,
      this.nameFuzzy,
      this.nameMatchScore});

  BankVerifyRequest.fromJson(Map<String, dynamic> json) {
    beneficiaryAccount = json['beneficiaryAccount'];
    beneficiaryIFSC = json['beneficiaryIFSC'];
    beneficiaryMobile = json['beneficiaryMobile'];
    beneficiaryName = json['beneficiaryName'];
    nameFuzzy = json['nameFuzzy'];
    nameMatchScore = json['nameMatchScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beneficiaryAccount'] = this.beneficiaryAccount;
    data['beneficiaryIFSC'] = this.beneficiaryIFSC;
    data['beneficiaryMobile'] = this.beneficiaryMobile;
    data['beneficiaryName'] = this.beneficiaryName;
    data['nameFuzzy'] = this.nameFuzzy;
    data['nameMatchScore'] = this.nameMatchScore;
    return data;
  }

  @override
  String toString() {
    return 'BankVerifyRequest{beneficiaryAccount: $beneficiaryAccount, beneficiaryIFSC: $beneficiaryIFSC, beneficiaryMobile: $beneficiaryMobile, beneficiaryName: $beneficiaryName, nameFuzzy: $nameFuzzy, nameMatchScore: $nameMatchScore}';
  }
}
