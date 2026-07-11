class BannerModel {
  int? id;
  String? imgUrl;
  String? redirectUrl;

  BannerModel({this.id, this.imgUrl, this.redirectUrl});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['imgUrl'];
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgUrl'] = this.imgUrl;
    data['redirectUrl'] = this.redirectUrl;
    return data;
  }
}
