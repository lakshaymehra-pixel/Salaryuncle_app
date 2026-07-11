class SaveDocModel {
  String? eventName;
  String? ext;
  var file;
  var index;
  var fileName;
  var doc_type;

  SaveDocModel(
      {this.eventName,
      this.ext,
      this.file,
      this.fileName,
      this.index,
      this.doc_type});

  @override
  String toString() {
    return 'SaveDocModel{eventName: $eventName, ext: $ext, file: $file, index: $index, fileName: $fileName, doc_type: $doc_type}';
  }

  SaveDocModel.fromJson(Map<String, dynamic> json) {
    eventName = json['docs_id'];
    ext = json['ext'];
    file = json['file'];
    index = json['index'];
    doc_type = json['doc_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docs_id'] = this.eventName;
    data['ext'] = this.ext;
    data['file'] = this.file;
    data['index'] = this.index;
    data['doc_type'] = this.doc_type;
    return data;
  }
}
