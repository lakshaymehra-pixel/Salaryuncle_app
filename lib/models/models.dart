class ContactsModel {
  String? leadId;
  String? logType;
  List<Contacts>? contacts;

  ContactsModel({this.leadId, this.contacts});

  ContactsModel.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    logType = json['logType'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['logType'] = this.logType;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  String? name;
  String? number;
  String? contactImage;

  Contacts({this.name, this.number, this.contactImage});

  Contacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    contactImage = json['contactImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    data['contactImage'] = this.contactImage;
    return data;
  }
}

class PeriodicDataModel {
  String? leadId;
  String? logType;
  String? latLong;
  List<Sms>? sms;
  List<CallLogs>? callLogs;

  PeriodicDataModel({this.leadId, this.latLong, this.sms, this.callLogs});

  PeriodicDataModel.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    logType = json['logType'];
    latLong = json['latLong'];
    if (json['sms'] != null) {
      sms = <Sms>[];
      json['sms'].forEach((v) {
        sms!.add(new Sms.fromJson(v));
      });
    }
    if (json['callLogs'] != null) {
      callLogs = <CallLogs>[];
      json['callLogs'].forEach((v) {
        callLogs!.add(new CallLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['logType'] = this.logType;
    data['latLong'] = this.latLong;
    if (this.sms != null) {
      data['sms'] = this.sms!.map((v) => v.toJson()).toList();
    }
    if (this.callLogs != null) {
      data['callLogs'] = this.callLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sms {
  String? name;
  String? number;
  String? body;

  Sms({this.name, this.number, this.body});

  Sms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    data['body'] = this.body;
    return data;
  }
}

class CallLogs {
  String? name;
  String? number;

  CallLogs({this.name, this.number});

  CallLogs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}
