import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/controller/preview_controller.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../controller/status_controller.dart';
import '../utils/events.dart';

class BasicDetailsCardApp extends GetView<PreviewController> {
  var statusController = Get.put(StatusController());
  var dashbroadController = Get.put(DashbroadController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBackground(
        heightOfUpperBox: 0.0,
        isUpperBoxVisible: false,
        isAppBarVisible: true,
        children: (controller.eventName.value != Events.REGISTER_NOW &&
                controller.eventName.value != Events.PANCARD &&
                controller.eventName.value != Events.PERSONAL_DETAILS &&
                controller.eventName.value != Events.RESIDENCE_DETAILS &&
                controller.eventName.value != Events.INCOME_DETAILS &&
                controller.eventName.value != Events.SELFIE_UPLOAD)
            ? [
                SizedBox(height: 15.sp),
                BasicDetailsCard(
                  list: [
                    buildDetailRow('Your Name', prefs.getString(SharedConstants.NAME) ?? "", context),
                    buildDetailRow(
                        'Gender',
                        (prefs.getString(SharedConstants.GENDER) ?? "") == "1"
                            ? "MALE"
                            : (prefs.getString(SharedConstants.GENDER) ?? "") == "2"
                                ? "FEMALE"
                                : "",
                        context),
                    buildDetailRow('DOB', prefs.getString(SharedConstants.DOB) ?? "", context),
                    buildDetailRow(
                        'Marital Status',
                        prefs.getString(SharedConstants.MARITALSTATUS) == "1"
                            ? "SINGLE"
                            : prefs.getString(SharedConstants.MARITALSTATUS) == "2"
                                ? "MARRIED"
                                : prefs.getString(SharedConstants.MARITALSTATUS) == "3"
                                    ? "DIVORCED"
                                    : "",
                        context),
                    buildDetailRow('Personal Email', prefs.getString(SharedConstants.EMAIL) ?? "", context),
                    if (prefs.getString(SharedConstants.MARITALSTATUS) == "2")
                      buildDetailRow('Spouse Name', prefs.getString(SharedConstants.SPOUSE_NAME) ?? "", context),
                    if (prefs.getString(SharedConstants.MARITALSTATUS) == "2")
                      buildDetailRow('Spouse Number', prefs.getString(SharedConstants.SPOUS_NUMBER) ?? "", context)
                  ],
                  tittle: "Basic Detail",
                  routeName: RoutesName.PersonalDetailsScreen,
                ),
                BasicDetailsCard(
                  routeName: RoutesName.ResidenceDetailsScreen,
                  list: [
                    buildDetailRow('Address Line 1', prefs.getString(SharedConstants.ADDRESS1) ?? "", context),
                    buildDetailRow('Address Line 2', prefs.getString(SharedConstants.ADDRESS2) ?? "", context),
                    buildDetailRow('Landmark', prefs.getString(SharedConstants.LANDMARK) ?? "", context),
                    buildDetailRow('Pin code', prefs.getString(SharedConstants.PINCODE) ?? "", context),
                    buildDetailRow('State', prefs.getString(SharedConstants.STATE) ?? "", context),
                    buildDetailRow('City', prefs.getString(SharedConstants.CITY) ?? "", context),
                    buildDetailRow(
                        'Residence Type',
                        (prefs.getString(SharedConstants.RESIDENCETYPE) ?? "") == "1"
                            ? "OWNED"
                            : (prefs.getString(SharedConstants.RESIDENCETYPE) ?? "") == "2"
                                ? "RENTED"
                                : (prefs.getString(SharedConstants.RESIDENCETYPE) ?? "") == "3"
                                    ? "OTHER"
                                    : "",
                        context),
                  ],
                  tittle: "Residence Address",
                ),
                BasicDetailsCard(
                  routeName: RoutesName.IncomeDetailsScreen,
                  list: [
                    buildDetailRow('Monthly Salary', prefs.getString(SharedConstants.SALARY) ?? "", context),
                    buildDetailRow('Salary Date', prefs.getString(SharedConstants.SALARY_DATE) ?? "", context),
                    buildDetailRow('Salary Mode', (prefs.getString(SharedConstants.SALARY_MODE) ?? ""), context),
                    buildDetailRow('Employment Type', prefs.getString(SharedConstants.EMP_TYPE) ?? "", context),
                  ],
                  tittle: "Income Details",
                ),
                if (Events.getCurrentEvent() > 8)
                  BasicDetailsCard(
                    routeName: RoutesName.LoanSelect,
                    argument: false,
                    list: [
                      buildDetailRow('Purpose', prefs.getString(SharedConstants.PURPOSE) ?? "", context),
                      buildDetailRow('Loan Amount', prefs.getString(SharedConstants.LOAN_AMOUNT) ?? "", context),
                      buildDetailRow('Tenure', prefs.getString(SharedConstants.TENURE) ?? "", context),
                    ],
                    tittle: "Loan Details",
                  ),
                if (Events.getCurrentEvent() > 9)
                  BasicDetailsCard(
                    routeName: RoutesName.EmploymentDetailsScreen,
                    list: [
                      buildDetailRow('Company Name', prefs.getString(SharedConstants.COMPANYNAME) ?? "", context),
                      buildDetailRow('Address Line 1', prefs.getString(SharedConstants.ADDRESS_OFFICE1) ?? "", context),
                      buildDetailRow('Address Line 2', prefs.getString(SharedConstants.ADDRESS_OFFICE2) ?? "", context),
                      buildDetailRow('Landmark', prefs.getString(SharedConstants.OFFICE_LANDMARK) ?? "", context),
                      buildDetailRow('Office Email', prefs.getString(SharedConstants.OFFICE_EMAIL) ?? "", context),
                      buildDetailRow('Employment Since', prefs.getString(SharedConstants.EMP_SINCE) ?? "", context),
                      buildDetailRow('Designation', prefs.getString(SharedConstants.DESIGNATION) ?? "", context),
                      buildDetailRow(
                          'Work Mode',
                          (prefs.getString(SharedConstants.WORK_MODE) ?? "") == "1"
                              ? "OnSite"
                              : (prefs.getString(SharedConstants.WORK_MODE) ?? "") == "2"
                                  ? "Remote"
                                  : (prefs.getString(SharedConstants.WORK_MODE) ?? ""),
                          context),
                      if ((prefs.getString(SharedConstants.DEPT_NAME) ?? "") != "")
                        buildDetailRow('Department', prefs.getString(SharedConstants.DEPT_NAME) ?? "", context),
                    ],
                    tittle: "Employment Details",
                  ),
                if (Events.getCurrentEvent() > 11)
                  BasicDetailsCard(
                    routeName: RoutesName.BankScreen,
                    list: [
                      buildDetailRow('Account Number', prefs.getString(SharedConstants.BANKNUMBER) ?? "", context),
                      buildDetailRow('Name on Account', prefs.getString(SharedConstants.NAMEONBANK) ?? "", context),
                      buildDetailRow('IFSC Code', prefs.getString(SharedConstants.IFSC) ?? '', context),
                      buildDetailRow('BRANCH NAME', prefs.getString(SharedConstants.BRANCH_NAME) ?? "", context),
                    ],
                    tittle: "Bank Details",
                  ),
                if (GetPlatform.isIOS)
                  SizedBox(
                    height: 25.sp,
                  )
              ]
            : [
                SizedBox(
                  height: (controller.eventName.value == Events.REGISTER_NOW)
                      ? GetPlatform.isIOS
                          ? Get.height * 0.652
                          : Get.height * 0.7
                      : Get.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15.sp),
                        if (Events.getCurrentEvent() > 3)
                          BasicDetailsCard(
                            routeName: RoutesName.PersonalDetailsScreen,
                            list: [
                              buildDetailRow('Your Name', prefs.getString(SharedConstants.NAME) ?? "", context),
                              buildDetailRow(
                                  'Gender',
                                  (prefs.getString(SharedConstants.GENDER) ?? "") == "1"
                                      ? "MALE"
                                      : (prefs.getString(SharedConstants.GENDER) ?? "") == "2"
                                          ? "FEMALE"
                                          : (prefs.getString(SharedConstants.GENDER) ?? ""),
                                  context),
                              buildDetailRow('DOB', prefs.getString(SharedConstants.DOB) ?? "", context),
                              buildDetailRow(
                                  'Marital Status',
                                  prefs.getString(SharedConstants.MARITALSTATUS) == "1"
                                      ? "SINGLE"
                                      : prefs.getString(SharedConstants.MARITALSTATUS) == "2"
                                          ? "MARRIED"
                                          : prefs.getString(SharedConstants.MARITALSTATUS) == "3"
                                              ? "DIVORCED"
                                              : "",
                                  context),
                              buildDetailRow('Personal Email', prefs.getString(SharedConstants.EMAIL) ?? "", context),
                              if (prefs.getString(SharedConstants.MARITALSTATUS) == "2")
                                buildDetailRow(
                                    'Spouse Name', prefs.getString(SharedConstants.SPOUSE_NAME) ?? "", context),
                              if (prefs.getString(SharedConstants.MARITALSTATUS) == "2")
                                buildDetailRow(
                                    'Spouse Number', prefs.getString(SharedConstants.SPOUS_NUMBER) ?? "", context)
                            ],
                            tittle: "Basic Detail",
                          ),
                        if (Events.getCurrentEvent() > 4)
                          BasicDetailsCard(
                            routeName: RoutesName.ResidenceDetailsScreen,
                            list: [
                              buildDetailRow(
                                  'Address Line 1', prefs.getString(SharedConstants.ADDRESS1) ?? "", context),
                              buildDetailRow(
                                  'Address Line 2', prefs.getString(SharedConstants.ADDRESS2) ?? "", context),
                              buildDetailRow('Landmark', prefs.getString(SharedConstants.LANDMARK) ?? "", context),
                              buildDetailRow('Pin code', prefs.getString(SharedConstants.PINCODE) ?? "", context),
                              buildDetailRow('State', prefs.getString(SharedConstants.STATE) ?? "", context),
                              buildDetailRow('City', prefs.getString(SharedConstants.CITY) ?? "", context),
                              buildDetailRow(
                                  'Residence Type',
                                  (prefs.getString(SharedConstants.RESIDENCETYPE) ?? "") == "1"
                                      ? "OWNED"
                                      : (prefs.getString(SharedConstants.RESIDENCETYPE) ?? "") == "2"
                                          ? "RENTED"
                                          : (prefs.getString(SharedConstants.RESIDENCETYPE) ?? "") == "3"
                                              ? "OTHER"
                                              : "",
                                  context),
                            ],
                            tittle: "Residence Address",
                          ),
                        if (Events.getCurrentEvent() > 5)
                          BasicDetailsCard(
                            routeName: RoutesName.IncomeDetailsScreen,
                            list: [
                              buildDetailRow('Monthly Salary', prefs.getString(SharedConstants.SALARY) ?? "", context),
                              buildDetailRow(
                                  'Salary Date', prefs.getString(SharedConstants.SALARY_DATE) ?? "", context),
                              buildDetailRow(
                                  'Salary Mode', (prefs.getString(SharedConstants.SALARY_MODE) ?? ""), context),
                              buildDetailRow(
                                  'Employment Type', prefs.getString(SharedConstants.EMP_TYPE) ?? "", context),
                            ],
                            tittle: "Income Details",
                          )
                      ],
                    ),
                  ),
                ),
                if (controller.eventName.value == Events.REGISTER_NOW)
                  CustomButton(
                    onPressed: () {
                      // if (prefs.getInt(SharedConstants.STEP_STAGE)! >
                      //     4) {
                      statusController.checkEligiblity(isRedirect: true);
                      // } else {
                      //   ShortMessage.toast(
                      //       title: "Please complete all steps");
                      // }
                      // Action when Preview Details is pressed
                    },
                    isLoading: statusController.loadingOnCheckEligiblity.value,
                    height: Get.height * 0.06,
                    text: prefs.getString(SharedConstants.USER_TYPE).toString().contains("REPEAT")
                        ? "RE-LOAN"
                        : 'CHECK ELIGIBILITY',
                  ),
              ],
      );
    });
  }
}

class BasicDetailsCard extends StatelessWidget {
  List<Widget> list = [];
  var tittle = "";
  String routeName;
  dynamic argument;

  BasicDetailsCard({required this.list, required this.tittle, required this.routeName, this.argument = ""});

  @override
  Widget build(BuildContext context) {
    var enableEdit = (prefs.getBool(SharedConstants.IS_EDITABLE) ?? false);

    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(16.sp),
        boxShadow: ColorConstants.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tittle,
                style: TextStyle(
                  color: ColorConstants.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (enableEdit) {
                    Get.offAllNamed(routeName, arguments: argument);
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  size: 16,
                ),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: enableEdit ? ColorConstants.primary : ColorConstants.muted,
                  // Background color
                  foregroundColor: Colors.white,
                  // Text color
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.sp,
          ),
          Column(
            children: list,
          )
        ],
      ),
    );
  }
}

Widget buildDetailRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * 0.4,
          child: Text(
            label,
            style: TextStyle(
                fontSize: 15.sp, color: ColorConstants.body, fontWeight: FontWeight.w700
                // fontStyle: FontStyle
                ),
          ),
        ),
        Expanded(
          // width: Get.width * 0.4,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: ColorConstants.ink,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
