class VerifyAadhaarOTP_Responsse {
  Data? data;
  int? statusCode;
  String? message;

  VerifyAadhaarOTP_Responsse({this.data, this.statusCode, this.message});

  VerifyAadhaarOTP_Responsse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  @override
  String toString() {
    return 'VerifyAadhaarOTP_Responsse{data: $data, statusCode: $statusCode, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  var clientId;
  var fullName;
  var aadhaarNumber;
  var dob;
  var gender;
  Address? address;
  bool? faceStatus;
  int? faceScore;
  var zip;
  var profileImage;
  var hasImage;
  var emailHash;
  var mobileHash;
  var rawXml;
  var zipData;
  var careOf;
  var shareCode;
  var mobileVerified;
  var referenceId;
  var aadhaarPdf;
  var status;
  var uniquenessId;

  Data(
      {this.clientId,
      this.fullName,
      this.aadhaarNumber,
      this.dob,
      this.gender,
      this.address,
      this.faceStatus,
      this.faceScore,
      this.zip,
      this.profileImage,
      this.hasImage,
      this.emailHash,
      this.mobileHash,
      this.rawXml,
      this.zipData,
      this.careOf,
      this.shareCode,
      this.mobileVerified,
      this.referenceId,
      this.aadhaarPdf,
      this.status,
      this.uniquenessId});

  Data.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    fullName = json['full_name'];
    aadhaarNumber = json['aadhaar_number'];
    dob = json['dob'];
    gender = json['gender'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    faceStatus = json['face_status'];
    faceScore = json['face_score'];
    zip = json['zip'];
    profileImage = json['profile_image'];
    hasImage = json['has_image'];
    emailHash = json['email_hash'];
    mobileHash = json['mobile_hash'];
    rawXml = json['raw_xml'];
    zipData = json['zip_data'];
    careOf = json['care_of'];
    shareCode = json['share_code'];
    mobileVerified = json['mobile_verified'];
    referenceId = json['reference_id'];
    aadhaarPdf = json['aadhaar_pdf'];
    status = json['status'];
    uniquenessId = json['uniqueness_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['full_name'] = this.fullName;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['face_status'] = this.faceStatus;
    data['face_score'] = this.faceScore;
    data['zip'] = this.zip;
    data['profile_image'] = this.profileImage;
    data['has_image'] = this.hasImage;
    data['email_hash'] = this.emailHash;
    data['mobile_hash'] = this.mobileHash;
    data['raw_xml'] = this.rawXml;
    data['zip_data'] = this.zipData;
    data['care_of'] = this.careOf;
    data['share_code'] = this.shareCode;
    data['mobile_verified'] = this.mobileVerified;
    data['reference_id'] = this.referenceId;
    data['aadhaar_pdf'] = this.aadhaarPdf;
    data['status'] = this.status;
    data['uniqueness_id'] = this.uniquenessId;
    return data;
  }
}

class Address {
  var country;
  var dist;
  var state;
  var po;
  var loc;
  var vtc;
  var subdist;
  var street;
  var house;
  var landmark;

  Address(
      {this.country,
      this.dist,
      this.state,
      this.po,
      this.loc,
      this.vtc,
      this.subdist,
      this.street,
      this.house,
      this.landmark});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    dist = json['dist'];
    state = json['state'];
    po = json['po'];
    loc = json['loc'];
    vtc = json['vtc'];
    subdist = json['subdist'];
    street = json['street'];
    house = json['house'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['dist'] = this.dist;
    data['state'] = this.state;
    data['po'] = this.po;
    data['loc'] = this.loc;
    data['vtc'] = this.vtc;
    data['subdist'] = this.subdist;
    data['street'] = this.street;
    data['house'] = this.house;
    data['landmark'] = this.landmark;
    return data;
  }
}
