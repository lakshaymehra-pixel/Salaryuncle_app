class RequiedDocs {
  var docType;
  var eventName;
  var name;
  var allowedFormat;
  var index;

  RequiedDocs(
      {this.docType,
      this.eventName,
      this.name,
      this.allowedFormat,
      this.index = 0});

  RequiedDocs.fromJson(Map<String, dynamic> json) {
    docType = json['doc_type'];
    eventName = json['event_name'];
    name = json['name'];
    allowedFormat = json['allowed_format'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doc_type'] = this.docType;
    data['event_name'] = this.eventName;
    data['name'] = this.name;
    data['allowed_format'] = this.allowedFormat;
    data['index'] = this.index;
    return data;
  }
}
