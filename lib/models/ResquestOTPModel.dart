class ResquestOtpModel {
  var _currentPage;

  var _mobile;

  ResquestOtpModel({
    required var currentPage,
    required var mobile,
  }) {
    _currentPage = currentPage;
    _mobile = mobile;
  }

  ResquestOtpModel.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _mobile = json['mobile'];
  }

  ResquestOtpModel copyWith({
    required String currentPage,
    required num mobile,
  }) =>
      ResquestOtpModel(
        currentPage: currentPage ?? _currentPage,
        mobile: mobile ?? _mobile,
      );

  String get currentPage => _currentPage;

  num get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['mobile'] = _mobile;
    return map;
  }
}
