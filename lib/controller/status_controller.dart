import 'package:get/get.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/services/api_service.dart';
import 'package:tejas_loan/views/eligiblity_falied_page.dart';

import '../main.dart';
import '../services/api_constant/api_constants.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class StatusController extends GetxController {
  var loading = false.obs;
  var loadingOnCheckEligiblity = false.obs;
  var status = 0.obs;
  var isEligible = (prefs.getBool(SharedConstants.ELIGIBLE) ?? false).obs;
  var token = prefs.getString(SharedConstants.TOKEN);

  @override
  void onInit() {
    print(isEligible.value);
    super.onInit();
  }

  checkEligiblity({var isRedirect = false}) async {
    if ((prefs.getBool(SharedConstants.ELIGIBLE) ?? false) &&
        prefs.getString(SharedConstants.STEP_STAGE) != Events.REGISTER_NOW) {
      if (isRedirect) {
        Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? '');
      } else {
        ShortMessage.toast(title: "Already Eligible");
      }
      isEligible.value = true;
      return null;
    }
    if (loadingOnCheckEligiblity.value == false) {
      isEligible.value = false;

      loadingOnCheckEligiblity.value = true;
      try {
        var result = await ApiService().postMethod(
            baseUrl: APIConstants.getBaseUrl(),
            body: {
              "profile_id": prefs.getString(SharedConstants.PROFILE_ID).toString(),
              "event_name": Events.REGISTER_NOW
            },
            header: APIConstants.getApiHeader(token));

        if (result != null) {
          if (result['Status'] == 1) {
            isEligible.value = true;
            prefs.setBool(SharedConstants.ELIGIBLE, true);
            prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step']);
            prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage']);

            ShortMessage.toast(title: result['Message']);

            if (isRedirect) {
              Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? '');
            }
          } else if (result['Status'] == 3) {
            // ShortMessage.toast(title: result['Message']);
            // ShortMessage.toast(title: result['Data']['eligibility_content']);
            ShortMessage.toast(title: result['Data']['eligibility_reason'], duration: 2);
            if (isRedirect) {
              prefs.setString(SharedConstants.REJECT_REASON, result['Data']['eligibility_reason'] ?? '');

              Get.to(EligiblityFaliedPage());
            }
          } else if (result['Status'] == 4) {
            ShortMessage.toast(title: result['Message']);
          } else {
            prefs.setBool(SharedConstants.ELIGIBLE, false);
            ShortMessage.toast(title: result['Message']);
          }
        } else {
          ShortMessage.toast(title: "Server Error");
        }
      } catch (e) {
        ShortMessage.toast(title: "Something went wrong");

        print(e);
      }

      loadingOnCheckEligiblity.value = false;
    } else {
      ShortMessage.toast(title: "Please wait");
    }
  }

// getLeadStatus(var lead_id) async {
//   if (loading.value == false) {
//     loading.value = true;
//
//     var step_stage = prefs.getInt(SharedConstants.STEP_STAGE) ?? 1;
//
//     if (step_stage == 1) {
//       Get.toNamed(RoutesName.PersonalDetailsScreen);
//     } else if (step_stage == 2) {
//       Get.toNamed(RoutesName.ResidenceDetailsScreen);
//     } else if (step_stage == 3) {
//       Get.toNamed(RoutesName.PersonalDetailsScreen);
//     } else if (step_stage == 4) {
//       Get.toNamed(RoutesName.IncomeDetailsScreen);
//     } else if (step_stage == 5) {
//       Get.toNamed(RoutesName.DocScreen, arguments: [true]);
//     } else if (step_stage == 6) {
//       Get.toNamed(RoutesName.DocScreen, arguments: [false]);
//     } else if (step_stage == 7) {
//       Get.toNamed(RoutesName.EmploymentDetailsScreen);
//     } else if (step_stage == 8) {
//       Get.toNamed(RoutesName.LoanSelect, arguments: false);
//     } else if (step_stage >= 9) {
//       Get.toNamed(RoutesName.LoanSelect, arguments: false);
//     } else {
//       Get.toNamed(RoutesName.OccupationScreen);
//     }
//     loading.value = false;
//   }
// }
}
