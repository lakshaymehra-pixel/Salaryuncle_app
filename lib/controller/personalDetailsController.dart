import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/models/cityIdsModel.dart';
import 'package:tejas_loan/models/resTypeModel.dart';
import 'package:tejas_loan/models/statesIdsModel.dart';
import 'package:tejas_loan/services/api_service.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../models/pincodeModel.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../utils/events.dart';
import 'internet_connectivity_controller.dart';

class PersonalDetailController extends GetxController {
  var isLoadingOnSubmit = false.obs;
  var emailController = TextEditingController(text: prefs.getString(SharedConstants.EMAIL)).obs;
  var emailOfficeController = TextEditingController(text: prefs.getString(SharedConstants.OFFICE_EMAIL)).obs;
  var nameController = TextEditingController(text: prefs.getString(SharedConstants.NAME)).obs;
  var aadhaarNumberController = TextEditingController(text: prefs.getString(SharedConstants.AADHAAR)).obs;
  var deptNameController = TextEditingController(text: prefs.getString(SharedConstants.DEPT_NAME)).obs;
  var designationController = TextEditingController(text: prefs.getString(SharedConstants.DESIGNATION)).obs;
  var serviceTenureController = TextEditingController(text: prefs.getString(SharedConstants.SERVICE_TENURE)).obs;
  var spouseNameController = TextEditingController(text: prefs.getString(SharedConstants.SPOUSE_NAME)).obs;
  var spouseNumberController = TextEditingController(text: prefs.getString(SharedConstants.SPOUS_NUMBER)).obs;
  var salaryController = TextEditingController(text: prefs.getString(SharedConstants.SALARY)).obs;
  var lastSalaryController = TextEditingController(text: prefs.getString(SharedConstants.SALARY_DATE)).obs;
  var obligationsController = TextEditingController().obs;
  var companyNameController = TextEditingController(text: prefs.getString(SharedConstants.COMPANYNAME)).obs;
  var loanController = TextEditingController().obs;
  var addressController1 = TextEditingController(text: prefs.getString(SharedConstants.ADDRESS1)).obs;
  var officeAddressController1 = TextEditingController(text: prefs.getString(SharedConstants.ADDRESS_OFFICE1)).obs;
  var officeAddressController2 = TextEditingController(text: prefs.getString(SharedConstants.ADDRESS_OFFICE2)).obs;
  var officeAddressController3 = TextEditingController(text: prefs.getString(SharedConstants.OFFICE_LANDMARK)).obs;
  var addressController2 = TextEditingController(text: prefs.getString(SharedConstants.ADDRESS2)).obs;
  var addressController3 = TextEditingController(text: prefs.getString(SharedConstants.LANDMARK)).obs;
  var isFoused = false.obs;
  var statesIdsList = <StatesIdsModel>[].obs;
  var cityIdsList = <CityIdsModel>[].obs;
  var pincodeList = <PinCodeModel>[].obs;
  var selectedState = StatesIdsModel(id: "0", name: "Select State").obs;
  var selectedStateId = "".obs;
  var appflyer_profile_id = prefs.getString(SharedConstants.APPFLYER_PROFILE_ID) ?? "";
  var deptList = [
    "SELECT",
    "SALES",
    "CREDIT",
    "ACCOUNTS",
    "FINANCE",
    "BUSINESS",
    "OPERATIONS",
    "TECHNOLOGY",
    "HUMAN RESOURCE",
    "OTHER"
  ].obs;
  var deptValue = "SELECT".obs;
  var selectedCity = CityIdsModel(mCityId: "0", mCityName: "Select City").obs;
  var selectedCityId = ''.obs;
  var selectedResTypeModel = Restypemodel(name: "Select", id: "0").obs;
  var selectedCompanyTypeModel = Restypemodel(name: "Select", id: "0").obs;
  var selectedResType = "".obs;
  var selectedPinCode = PinCodeModel(name: "Select Pincode").obs;
  var selectedPinCodeValue = TextEditingController(text: prefs.getString(SharedConstants.PINCODE)).obs;
  var selectedOfficePinCodeValue = TextEditingController(text: prefs.getString(SharedConstants.EMP_PINCODE)).obs;
  var singingCharacter = {"Married", "Single", "Divorced", "none"}.obs;
  var companyTypeList = <Restypemodel>[].obs;
  var resTypeList = <Restypemodel>[].obs; //["SELECT", "OWNED", "RENTED", "OTHER"]
  var currentMaritalSelected = (prefs.getString(SharedConstants.MARITALSTATUS) ?? "0").obs;
  var currentGenderSelected = (prefs.getString(SharedConstants.GENDER) ?? "0").obs;
  var currentEmploymentTypeSelected = (prefs.getString(SharedConstants.EMP_TYPE_ID) ?? "0").obs;
  var currentEmpModeSelected = "0".obs;
  var currentWorkModeSelected = "0".obs;
  var currentModeSelected = (prefs.getString(SharedConstants.SALARY_MODE_ID) ?? "0").obs;
  var selectedDate = DateTime.now().obs;
  var dobDate = DateTime.now().obs;
  var empSinceDate = DateTime.now().obs;
  var lastPayDate = DateTime.now().obs;
  var dobController = TextEditingController(text: prefs.getString(SharedConstants.DOB)).obs;
  var empSinceController = TextEditingController(text: prefs.getString(SharedConstants.EMP_SINCE)).obs;
  var lastPayDateController = TextEditingController(text: prefs.getString(SharedConstants.SALARY_DATE)).obs;
  ConnectionManagerController connectionManagerController = Get.find<ConnectionManagerController>();
  var token = prefs.getString(SharedConstants.TOKEN) ?? "";
  final df = DateFormat('yyyy-MM-dd');
  final df1 = DateFormat('dd-MM-yyyy');

  //check date format:
  bool isDateInFormat(String dateString, String format) {
    try {
      DateFormat dateFormat = DateFormat(format);
      dateFormat.parseStrict(dateString); // Ensure strict parsing
      return true;
    } catch (e) {
      return false;
    }
  }

  String getFormattedDate(final String date) {
    try {
      // Detect the input format
      String inputFormatPattern = isDateInFormat(date, 'dd-MM-yyyy') ? 'dd-MM-yyyy' : 'yyyy-MM-dd';
      String outputFormatPattern = inputFormatPattern == 'dd-MM-yyyy' ? 'yyyy-MM-dd' : 'dd-MM-yyyy';

      // Parse the date using the detected format
      final inputFormat = DateFormat(inputFormatPattern);
      final updatedDate = inputFormat.parse(date);

      // Format the date into the desired output format
      final outputFormat = DateFormat(outputFormatPattern);
      final converted = outputFormat.format(updatedDate);

      debugPrint("original: $date");
      debugPrint("converted: $converted");

      return converted;
    } catch (e) {
      return date; // Return the original date if parsing fails
    }
  }

  @override
  void onInit() async {
    setRestType();

    nameController.value.text = prefs.getString(SharedConstants.NAME) ?? "";

    // dobController.value.text = "05-07-2001" ?? "";
    currentGenderSelected = (prefs.getString(SharedConstants.GENDER) ?? "0").obs;

    final dobValue = prefs.getString(SharedConstants.DOB) ?? "";
    if (dobValue.isNotEmpty) {
      dobController.value.text = getFormattedDate(dobValue);
      try {
        dobDate.value = DateTime.parse(dobController.value.text);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    final salaryDate = prefs.getString(SharedConstants.SALARY_DATE) ?? "";
    if (salaryDate.isNotEmpty) {
      lastPayDateController.value.text = getFormattedDate(salaryDate);
    }

    final empSince = prefs.getString(SharedConstants.EMP_SINCE) ?? "";
    if (empSince.isNotEmpty) {
      empSinceController.value.text = getFormattedDate(empSince);
    }

    // selectedResTypeModel
    final residenceType = prefs.getString(SharedConstants.RESIDENCETYPE) ?? "";
    if (residenceType.isNotEmpty) {
      selectedResTypeModel.value = resTypeList.where((p0) => p0.id == residenceType).first;
    }
    //company id /type
    final companyType = prefs.getString(SharedConstants.COMPANYTYPE) ?? "";
    if (companyType.isNotEmpty) {
      selectedCompanyTypeModel.value = companyTypeList.where((p0) => p0.id == companyType).first;
    }

    //dept name
    final deptName = prefs.getString(SharedConstants.DEPT_NAME) ?? "";
    if (deptName.isNotEmpty) {
      deptValue.value = deptList.where((p0) => p0 == deptName).first;
    }

    super.onInit();
  }

  setRestType() {
    resTypeList.clear();
    resTypeList.value = [
      Restypemodel(name: "SELECT", id: "0"),
      Restypemodel(name: "OWNED", id: "1"),
      Restypemodel(name: "RENTED", id: "2"),
      Restypemodel(name: "OTHER", id: "3"),
    ];

    companyTypeList.clear();
    companyTypeList.value = [
      Restypemodel(name: "SELECT", id: "0"),
      Restypemodel(name: "Private", id: "1"),
      Restypemodel(name: "Public", id: "2"),
      Restypemodel(name: "Listed Public", id: "3"),
      Restypemodel(name: "State Government", id: "4"),
      Restypemodel(name: "Central Government", id: "5"),
      Restypemodel(name: "Partnership Firm", id: "6"),
      Restypemodel(name: "Proprietorship Firm", id: "7"),
      Restypemodel(name: "Limited Liability Partnership(LLP)", id: "8"),
      Restypemodel(name: "Trust", id: "9"),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    nameController.value.dispose();
    dobController.value.dispose();
    empSinceController.value.dispose();
    lastPayDateController.value.dispose();
    emailController.value.dispose();
    emailOfficeController.value.dispose();
    deptNameController.value.dispose();
    designationController.value.dispose();
    serviceTenureController.value.dispose();
    spouseNameController.value.dispose();
    spouseNumberController.value.dispose();
    salaryController.value.dispose();
    obligationsController.value.dispose();
    companyNameController.value.dispose();
    loanController.value.dispose();
    addressController1.value.dispose();
    officeAddressController1.value.dispose();
    officeAddressController2.value.dispose();
    addressController2.value.dispose();
    addressController3.value.dispose();
  }

  Future<void> selectDate(
      {required BuildContext context, var isNextPayDate = false, var isEmploymentDate = false}) async {
    if (isEmploymentDate) {
      if (empSinceController.value.text.isEmpty) {
        selectedDate.value = DateTime.now();
      } else {
        try {
          debugPrint(empSinceController.value.text);
          selectedDate.value = DateTime.parse(getFormattedDate(empSinceController.value.text));
        } catch (e) {
          selectedDate.value = DateTime.now();
          debugPrint(e.toString());
        }
      }
    } else if (isNextPayDate) {
      if (lastPayDateController.value.text.isEmpty) {
        selectedDate.value = DateTime.now();
      } else {
        selectedDate.value = DateTime.parse(getFormattedDate(lastPayDateController.value.text));
      }
    } else {
      DateTime date = DateTime.now();

      if (dobController.value.text.isEmpty) {
        selectedDate.value = DateTime(date.subtract(const Duration(days: 7670)).year);
      } else {
        selectedDate.value = DateTime.parse(getFormattedDate(dobController.value.text));
      }
    }
    final DateTime? dateTime = await showCupertinoModalPopup(
      context: context,
      builder: (_) {
        final size = MediaQuery.of(context).size;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          height: size.height * 0.27,
          child: CupertinoDatePicker(
            initialDateTime: selectedDate.value,
            minimumDate: DateTime(1950, 8),
            maximumDate: isEmploymentDate
                ? DateTime.now()
                : isNextPayDate
                ? DateTime.now()
                : DateTime(DateTime.now().subtract(Duration(days: 7670)).year),
            mode: CupertinoDatePickerMode.date,
            dateOrder: DatePickerDateOrder.dmy,
            onDateTimeChanged: (picked) {
              if (picked != null && picked != selectedDate) {
                if (isEmploymentDate) {
                  empSinceController.value.text = df1.format(picked);
                  empSinceDate.value = picked;
                }
                if (!isNextPayDate) {
                  dobController.value.text = df1.format(picked);
                  dobDate.value = picked;
                  prefs.setString(SharedConstants.DOB, dobController.value.text.toString());
                } else {
                  lastPayDateController.value.text = df1.format(picked);
                  lastPayDate.value = picked;
                }
                // print("${df.format(picked)}");
              }
            },
          ),
        );
      },
    );
  }

  void savePersonalDetails() async {
    // try {
    //   GeoLocation().determinePosition().then((value) => prefs.setString(
    //       SharedConstants.LATLONG,
    //       "${value.latitude.toString()},${value.longitude.toString()}"));
    // } catch (e) {
    //   prefs.setString(SharedConstants.LATLONG, "0.0/0.0");
    //   debugPrint(e);
    // }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.value.text.trim());
    if (emailController.value.text.trim().split("@").last.split(".").last.length <= 1) {
      emailValid = false;
    }

    if (!emailValid) {
      ShortMessage.toast(title: "Please Enter Valid Email");
    } else if (nameController.value.text.isEmpty) {
      ShortMessage.toast(title: "Please Enter Name");
    } else if (dobController.value.text.isEmpty) {
      ShortMessage.toast(title: "Please Select DOB");
    } else if (currentGenderSelected.value == "0") {
      ShortMessage.toast(title: "Please Select Gender");
    } else if (currentMaritalSelected.value == "0") {
      ShortMessage.toast(title: "Please Select Marital Status");
    } else if (currentMaritalSelected.value == "2" && spouseNameController.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Spouse Name");
    } else if (currentMaritalSelected.value == "2" && spouseNumberController.value.text.trim().length < 10) {
      debugPrint("length${spouseNumberController.value.text.trim().length}");
      ShortMessage.toast(title: "Please Enter Valid Spouse Mobile Number");
    } else if (currentMaritalSelected.value == "2" &&
        ["0", "1", "2", "3", "4", "5"].contains(spouseNumberController.value.text.split("")[0].toString())) {
      ShortMessage.toast(title: "Please Enter Valid Spouse Mobile Number");
    } else if (currentMaritalSelected.value == "2" &&
        spouseNumberController.value.text.trim() == (prefs.getString(SharedConstants.MOBILE)).toString().trim()) {
      debugPrint("length${spouseNumberController.value.text.trim().length}");

      ShortMessage.toast(title: "Spouse Mobile Number cannot be same as your Mobile Number");
    } else {
      debugPrint("length${spouseNumberController.value.text.trim().length}");

      if (currentMaritalSelected.value != "none" &&
          currentGenderSelected.value != "none" &&
          dobController.value.text.isNotEmpty) {
        isLoadingOnSubmit.value = true;

        try {
          if (dobController.value.text.isNotEmpty) {
            dobController.value.text = getFormattedDate(dobController.value.text);
            dobDate.value = DateTime.parse(dobController.value.text);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
        prefs.setString(SharedConstants.EMAIL, emailController.value.text);
        prefs.setString(SharedConstants.SPOUSE_NAME, spouseNameController.value.text);
        prefs.setString(SharedConstants.SPOUS_NUMBER, spouseNumberController.value.text);
        prefs.setString(SharedConstants.NAME, nameController.value.text);

        var number = prefs.getString(SharedConstants.MOBILE);
        var profileId = prefs.getString(SharedConstants.PROFILE_ID);

        try {
          var result = await ApiService().postMethod(
              baseUrl: APIConstants.getBaseUrl(),
              body: {
                "personal_email": emailController.value.text.trim(),
                "first_name": nameController.value.text.trim(),
                "spouse_name": spouseNameController.value.text.trim(),
                "spouse_mobile": spouseNumberController.value.text.trim(),
                "marital_status_id": currentMaritalSelected.value,
                "profile_id": profileId,
                // "profile_id": "21778",
                "event_name": Events.PERSONAL_DETAILS,
                "dob": dobController.value.text.split("-")[0].split("").length > 2
                    ? dobController.value.text.trim()
                    : df.format(dobDate.value),
                "gender": currentGenderSelected.value,
              },
              header: APIConstants.getApiHeader(token));

          if (result != null) {
            // appsflyerSdk!.setCustomerUserId(appflyer_profile_id.toString());
            //
            // appsflyerSdk!.logEvent("save_personal_info", {
            //   "profile_id": profile_id.toString(),
            //   "status": result['Status'],
            //   "message": result['Message'],
            // }).then((result) {
            //   debugPrint('Event successfully logged: $result');
            // }).catchError((error) {
            //   debugPrint('Error logging event: $error');
            // });
            isLoadingOnSubmit.value = false;
            if (result['Status'] == 1) {
              prefs.setString(SharedConstants.MOBILE, number.toString());

              ShortMessage.toast(title: result['Message'].toString());

              prefs.setString(SharedConstants.GENDER, currentGenderSelected.value == "1" ? "Male" : "Female");
              prefs.setString(SharedConstants.NAME, nameController.value.text);
              prefs.setString(SharedConstants.MARITALSTATUS, currentMaritalSelected.value);
              prefs.setString(SharedConstants.EMAIL, emailController.value.text);

              prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
              prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
              Events.getNextEvent(result['Data']['next_step'].toString());
            } else if (result['Status'] == 3) {
              Get.offAllNamed(RoutesName.DashbroadScreen);
              ShortMessage.toast(title: result['Message'].toString());
            } else if (result['Status'] == 4) {
              Events.logout();
              ShortMessage.toast(title: result['Message'].toString());
            } else {
              ShortMessage.toast(title: result['Message'].toString());
            }
          } else {
            ShortMessage.toast(title: "Something went wrong");
          }
        } catch (e) {
          ShortMessage.toast(title: "Something went wrong");
        }
      } else {
        ShortMessage.toast(title: "Please Enter All Details");
      }
    }
    isLoadingOnSubmit.value = false;
  }

  void saveIncomeDetails() async {
    // try {
    //   GeoLocation().determinePosition().then((value) => prefs.setString(
    //       SharedConstants.LATLONG,
    //       "${value.latitude.toString()},${value.longitude.toString()}"));
    // } catch (e) {
    //   prefs.setString(SharedConstants.LATLONG, "0.0/0.0");
    //   debugPrint(e);
    // }

    if (!["1", "2"].contains(currentEmploymentTypeSelected.value)) {
      ShortMessage.toast(title: "Please Select Employment Type");
    } else if (salaryController.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Income");
    } else if (currentModeSelected.value == "0") {
      ShortMessage.toast(title: "Please Select Income Mode");
    } else if (lastPayDateController.value.text.isEmpty) {
      ShortMessage.toast(title: "Please Select Last Pay Date");
    } else {
      isLoadingOnSubmit.value = true;
      try {
        // final salaryDate = prefs.getString(SharedConstants.SALARY_DATE) ?? "";
        if (lastPayDateController.value.text.isNotEmpty) {
          lastPayDateController.value.text = getFormattedDate(lastPayDateController.value.text);
          lastPayDate.value = DateTime.parse(lastPayDateController.value.text);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      prefs.setString(SharedConstants.SALARY, salaryController.value.text);
      prefs.getString(SharedConstants.MOBILE);
      var profileId = prefs.getString(SharedConstants.PROFILE_ID);
      var result = await ApiService().postMethod(
          baseUrl: APIConstants.getBaseUrl(),
          body: {
            "profile_id": profileId,
            "event_name": Events.INCOME_DETAILS,
            "monthly_income": salaryController.value.text.trim(),
            "income_type_id": currentEmploymentTypeSelected.value,
            "salary_mode_id": int.parse(currentModeSelected.value),
            "salary_date": df.format(lastPayDate.value),
          },
          header: APIConstants.getApiHeader(token));
      if (result != null) {
        // appsflyerSdk!.setCustomerUserId(appflyer_profile_id.toString());
        //
        // appsflyerSdk!.logEvent("save_income_info", {
        //   "profile_id": profile_id.toString(),
        //   "status": result['Status'],
        //   "message": result['Message'],
        // }).then((result) {
        //   debugPrint('Event successfully logged: $result');
        // }).catchError((error) {
        //   debugPrint('Error logging event: $error');
        // });
        if (result['Status'] == 1) {
          ShortMessage.toast(title: result['Message'].toString());
          prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
          prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
          prefs.setString(
              SharedConstants.EMP_TYPE, currentEmpModeSelected.value.toString() == "1" ? "SALARIED" : "SELF EMPLOYED");
          prefs.setString(SharedConstants.SALARY_MODE, currentModeSelected.value == "1" ? "Bank" : "CASH");
          Events.getNextEvent(result['Data']['next_step'].toString());
        } else if (result['Status'] == 3) {
          Get.offAllNamed(RoutesName.DashbroadScreen);
          ShortMessage.toast(title: result['Message'].toString());
        } else if (result['Status'] == 4) {
          Events.logout();
          ShortMessage.toast(title: result['Message'].toString());
        } else {
          ShortMessage.toast(title: result['Message'].toString());
        }
      } else {
        ShortMessage.toast(title: "Something went wrong");
      }
    }
    isLoadingOnSubmit.value = false;
  }

  void saveResidentialDetails() async {
    // try {
    //   GeoLocation().determinePosition().then((value) => prefs.setString(
    //       SharedConstants.LATLONG,
    //       "${value.latitude.toString()},${value.longitude.toString()}"));
    // } catch (e) {
    //   prefs.setString(SharedConstants.LATLONG, "0.0/0.0");
    //   debugPrint(e);
    // }
    //
    // debugPrint("Address1  " + addressController1.value.text.trim().length.toString());
    // return;

    if (addressController1.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Address1");
    } else if (addressController2.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Address2");
    } else if (selectedPinCodeValue.value.text.length > 6) {
      ShortMessage.toast(title: "Please Enter Valid Pincode");
    } else if (selectedResTypeModel.value.id == "0") {
      ShortMessage.toast(title: "Please Select Address Type");
    } else {
      isLoadingOnSubmit.value = true;

      prefs.setString(SharedConstants.ADDRESS1, addressController1.value.text);
      prefs.setString(SharedConstants.ADDRESS2, addressController2.value.text);
      prefs.setString(SharedConstants.LANDMARK, addressController3.value.text);
      prefs.setString(SharedConstants.CITY, selectedCityId.value);
      prefs.setString(SharedConstants.STATE, selectedStateId.value);
      prefs.setString(SharedConstants.PINCODE, selectedPinCodeValue.value.text.toString());
      prefs.setString(SharedConstants.EMAIL, emailController.value.text);
      prefs.setString(SharedConstants.SALARY, salaryController.value.text);
      prefs.setString(SharedConstants.SPOUSE_NAME, spouseNameController.value.text);
      prefs.setString(SharedConstants.SPOUS_NUMBER, spouseNumberController.value.text);
      prefs.setString(SharedConstants.NAME, nameController.value.text);

      var profileId = prefs.getString(SharedConstants.PROFILE_ID);
      try {
        var result = await ApiService().postMethod(
            baseUrl: APIConstants.getBaseUrl(),
            body: {
              "profile_id": profileId.toString(),
              "event_name": Events.RESIDENCE_DETAILS,
              "residence_address_1": addressController1.value.text.trim(),
              "residence_address_2": addressController2.value.text.trim(),
              "residence_landmark": addressController3.value.text.trim(),
              "residence_pincode": selectedPinCodeValue.value.text.toString(),
              "residence_type_id": selectedResTypeModel.value.id.toString(),
            },
            header: APIConstants.getApiHeader(token));
        if (result != null) {
          // appsflyerSdk!.setCustomerUserId(appflyer_profile_id.toString());
          //
          // appsflyerSdk!.logEvent("save_residential_details", {
          //   "profile_id": profile_id.toString(),
          //   "status": result['Status'],
          //   "message": result['Message'],
          // }).then((result) {
          //   debugPrint('Event successfully logged: $result');
          // }).catchError((error) {
          //   debugPrint('Error logging event: $error');
          // });
          isLoadingOnSubmit.value = false;
          if (result['Status'] == 1) {
            ShortMessage.toast(title: result['Message'].toString());
            prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
            prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
            Events.getNextEvent(result['Data']['next_step'].toString());
          } else if (result['Status'] == 3) {
            Get.offAllNamed(RoutesName.DashbroadScreen);
            ShortMessage.toast(title: result['Message'].toString());
          } else if (result['Status'] == 4) {
            Events.logout();
            ShortMessage.toast(title: result['Message'].toString());
          } else {
            ShortMessage.toast(title: result['Message'].toString());
          }
        } else {
          isLoadingOnSubmit.value = false;
          ShortMessage.toast(title: "Something went wrong");
        }
      } catch (e) {
        ShortMessage.toast(title: "Internal Server Error");
        debugPrint(e.toString());
      }
    }
    isLoadingOnSubmit.value = false;
  }

  void saveEmploymentDetails() async {
    // try {
    //   GeoLocation().determinePosition().then((value) => prefs.setString(
    //       SharedConstants.LATLONG,
    //       "${value.latitude.toString()},${value.longitude.toString()}"));
    // } catch (e) {
    //   prefs.setString(SharedConstants.LATLONG, "0.0/0.0");
    //   debugPrint("ERROR ==>" + e.toString());
    // }
    bool emailValid = true;
    if (emailOfficeController.value.text.trim().isNotEmpty) {
      emailValid =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(emailOfficeController.value.text.trim());
      // Additional validation for the domain extension length
      if (emailOfficeController.value.text.trim().split("@").last.split(".").last.length <= 1) {
        emailValid = false;
      }
    }
    if (currentWorkModeSelected.value == "0") {
      ShortMessage.toast(title: "Please Select Current Work Mode");
    } else if (emailOfficeController.value.text.toString() == prefs.getString(SharedConstants.EMAIL)) {
      ShortMessage.toast(title: "Office Email Id Can't Be Same As Personal Email Id");
    } else if (companyNameController.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Organisation Name");
    } else if (deptValue.value == "SELECT") {
      ShortMessage.toast(title: "Please Select Department");
    } else if (selectedCompanyTypeModel.value.id == "0") {
      ShortMessage.toast(title: "Please Select Company Type");
    } else if (!emailValid) {
      ShortMessage.toast(title: "Please Enter Valid Office Email Id");
    } else if (designationController.value.text.isEmpty) {
      ShortMessage.toast(title: "Please Enter Designation");
    } else if (empSinceController.value.text.isEmpty) {
      ShortMessage.toast(title: "Please Select Employee Since");
    } else if (officeAddressController1.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Office Address");
    } else if (officeAddressController2.value.text.trim().length < 3) {
      ShortMessage.toast(title: "Please Enter Valid Office Address2");
    } else if (selectedOfficePinCodeValue.value.text.length < 6) {
      ShortMessage.toast(title: "Please Enter Valid Pincode");
    } else {
      isLoadingOnSubmit.value = true;

      prefs.setString(SharedConstants.ADDRESS_OFFICE1, officeAddressController1.value.text);
      prefs.setString(SharedConstants.ADDRESS_OFFICE2, officeAddressController2.value.text);
      prefs.setString(SharedConstants.DESIGNATION, designationController.value.text);
      prefs.setString(SharedConstants.STATE, selectedStateId.value);
      prefs.setString(SharedConstants.PINCODE, selectedPinCodeValue.value.text.toString());
      prefs.setString(SharedConstants.OFFICE_EMAIL, emailOfficeController.value.text);
      prefs.setString(SharedConstants.COMPANYNAME, companyNameController.value.text);
      prefs.setString(SharedConstants.COMPANYTYPE, selectedCompanyTypeModel.value.id);
      prefs.setString(
          SharedConstants.WORK_MODE,
          currentWorkModeSelected.value == "1"
              ? "OnSite"
              : currentWorkModeSelected.value == "2"
                  ? "Remote"
                  : "");

      try {
        if (empSinceController.value.text.isNotEmpty) {
                empSinceController.value.text = getFormattedDate(empSinceController.value.text);
                empSinceDate.value = DateTime.parse(empSinceController.value.text);
              }
      } catch (e) {
        debugPrint(e.toString());
      }


      prefs.setString(SharedConstants.EMP_SINCE, empSinceController.value.text);

      prefs.setString(SharedConstants.DEPT_NAME, deptValue.value);

      try {
        prefs.getString(SharedConstants.MOBILE);
        var profileId = prefs.getString(SharedConstants.PROFILE_ID) ?? "";
        var result = await ApiService().postMethod(
            baseUrl: APIConstants.getBaseUrl(uri: "saveleadDetails"),
            body: {
              "profile_id": profileId,
              "event_name": Events.EMPLOYMENT_DETAILS,
              "work_mode": currentWorkModeSelected.value.toString(),
              "office_email": emailOfficeController.value.text.toString().trim(),
              "company_name": companyNameController.value.text.toString().trim(),
              "department": deptValue.value,
              "company_type_id": "1",
              "designation": designationController.value.text.toString().trim(),
              "address_1": officeAddressController1.value.text.toString().trim(),
              "address_2": officeAddressController2.value.text.toString().trim(),
              "landmark": officeAddressController3.value.text.toString().trim(),
              "emp_since": df.format(empSinceDate.value).toString(),
              "pincode": selectedOfficePinCodeValue.value.text.toString(),
            },
            header: APIConstants.getApiHeader(token));
        if (result != null) {
          // appsflyerSdk!.setCustomerUserId(appflyer_profile_id.toString());
          // appsflyerSdk!.logEvent("save_employment_details ", {
          //   "status": result['Status'],
          //   "message": result['Message'],
          //   "profile_id": profile_id.toString(),
          // }).then((result) {
          //   debugPrint('Event successfully logged: $result');
          // }).catchError((error) {
          //   debugPrint('Error logging event: $error');
          // });
          isLoadingOnSubmit.value = false;
          if (result['Status'] == 1) {
            ShortMessage.toast(title: result['Message'].toString());
            prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
            prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
            Events.getNextEvent(result['Data']['next_step'].toString());
          } else if (result['Status'] == 3) {
            Get.offAllNamed(RoutesName.DashbroadScreen);
            ShortMessage.toast(title: result['Message'].toString());
          } else if (result['Status'] == 4) {
            Events.logout();
            ShortMessage.toast(title: result['Message'].toString());
          } else {
            ShortMessage.toast(title: result['Message'].toString());
          }
        } else {
          isLoadingOnSubmit.value = false;
          ShortMessage.toast(title: "Something went wrong");
        }
      } catch (e) {
        debugPrint(e.toString());
        ShortMessage.toast(title: "Something went wrong!!");
      }
    }
    isLoadingOnSubmit.value = false;
  }
}
