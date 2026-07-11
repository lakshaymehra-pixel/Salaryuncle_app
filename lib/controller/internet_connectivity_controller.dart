import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';

class ConnectionManagerController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  RxBool connectionType = false.obs;
  var connectedVia = "".obs;
  ConnectivityResult? connectivityResult;

  final Connectivity connectivity = Connectivity();

  late StreamSubscription streamSubscription;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    streamSubscription =
        connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<bool> checkConnectivity() async {
    final connectivityResult = await connectivity.checkConnectivity();
    debugPrint("Internet connectivity result:==>$connectivityResult");

    return _updateState(connectivityResult);
  }

  Future<void> getConnectivityType() async {
    late List<ConnectivityResult> connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());

      debugPrint("Internet connectivity result:==>$connectivityResult");


    } catch (e) {
      debugPrint("Internet connectivity error:==>$e");
    }
    return _updateState(connectivityResult);
  }

  _updateState(List<ConnectivityResult> result) {
    connectivityResult = result[0];
    switch (result[0]) {
      case ConnectivityResult.wifi:
        connectedVia.value = "Wifi";
        connectionType.value = true;
        return true;
      case ConnectivityResult.mobile:
        connectedVia.value = "Mobile";
        connectionType.value = true;
        return true;
      case ConnectivityResult.none:
        connectedVia.value = "None";
        connectionType.value = false;
        // Get.to(NoInternetScreen());
        return false;
      default:
        connectedVia.value = "";
        connectionType.value = false;
        // Get.to(NoInternetScreen());
        ShortMessage.snackBar(title: 'Failed to get connection type');
        return false;
    }
  }

  @override
  void onClose() {
    streamSubscription.cancel();
  }
}
