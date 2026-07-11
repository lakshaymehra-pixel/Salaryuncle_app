class BankVerifyResponse {
  Result? result;

  BankVerifyResponse({this.result});

  BankVerifyResponse.fromJson(Map<String, dynamic> json) {
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
  String? active;
  String? reason;
  String? nameMatch;
  String? mobileMatch;
  String? signzyReferenceId;
  AuditTrail? auditTrail;
  int? nameMatchScore;
  BankTransfer? bankTransfer;

  Result(
      {this.active,
      this.reason,
      this.nameMatch,
      this.mobileMatch,
      this.signzyReferenceId,
      this.auditTrail,
      this.nameMatchScore,
      this.bankTransfer});

  Result.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    reason = json['reason'];
    nameMatch = json['nameMatch'];
    mobileMatch = json['mobileMatch'];
    signzyReferenceId = json['signzyReferenceId'];
    auditTrail = json['auditTrail'] != null
        ? new AuditTrail.fromJson(json['auditTrail'])
        : null;
    nameMatchScore = json['nameMatchScore'];
    bankTransfer = json['bankTransfer'] != null
        ? new BankTransfer.fromJson(json['bankTransfer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['reason'] = this.reason;
    data['nameMatch'] = this.nameMatch;
    data['mobileMatch'] = this.mobileMatch;
    data['signzyReferenceId'] = this.signzyReferenceId;
    if (this.auditTrail != null) {
      data['auditTrail'] = this.auditTrail!.toJson();
    }
    data['nameMatchScore'] = this.nameMatchScore;
    if (this.bankTransfer != null) {
      data['bankTransfer'] = this.bankTransfer!.toJson();
    }
    return data;
  }
}

class AuditTrail {
  String? nature;
  String? value;
  String? timestamp;

  AuditTrail({this.nature, this.value, this.timestamp});

  AuditTrail.fromJson(Map<String, dynamic> json) {
    nature = json['nature'];
    value = json['value'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nature'] = this.nature;
    data['value'] = this.value;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class BankTransfer {
  String? response;
  String? bankRRN;
  String? beneName;
  String? beneMMID;
  String? beneMobile;
  String? beneIFSC;

  BankTransfer(
      {this.response,
      this.bankRRN,
      this.beneName,
      this.beneMMID,
      this.beneMobile,
      this.beneIFSC});

  BankTransfer.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    bankRRN = json['bankRRN'];
    beneName = json['beneName'];
    beneMMID = json['beneMMID'];
    beneMobile = json['beneMobile'];
    beneIFSC = json['beneIFSC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['bankRRN'] = this.bankRRN;
    data['beneName'] = this.beneName;
    data['beneMMID'] = this.beneMMID;
    data['beneMobile'] = this.beneMobile;
    data['beneIFSC'] = this.beneIFSC;
    return data;
  }

  @override
  String toString() {
    return 'BankTransfer{response: $response, bankRRN: $bankRRN, beneName: $beneName, beneMMID: $beneMMID, beneMobile: $beneMobile, beneIFSC: $beneIFSC}';
  }
}
