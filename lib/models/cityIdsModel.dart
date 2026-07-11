class CityIdsModel {
  String? mCityId;
  String? mCityName;

  CityIdsModel({this.mCityId, this.mCityName});

  CityIdsModel.fromJson(Map<String, dynamic> json) {
    mCityId = json['m_city_id'];
    mCityName = json['m_city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_city_id'] = this.mCityId;
    data['m_city_name'] = this.mCityName;
    return data;
  }
}
