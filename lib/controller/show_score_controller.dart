import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

class ShowScoreController extends GetxController {
  var score = int.parse(prefs.getString(SharedConstants.CIBIL) ?? "00").obs;
  var loading = true.obs;

  @override
  void onInit() {
    // getScore();
    super.onInit();
  }

  getScore() async {
    // loading.value = true;
    try {
      score.value = await int.parse(prefs.getString(SharedConstants.CIBIL) ?? "00");
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }
}
