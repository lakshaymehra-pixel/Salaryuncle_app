// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
// import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
//
// import '../custom_widgets/custom_toast_snack_bar.dart';
// import '../main.dart';
// import '../services/api_constant/api_constants.dart';
// import '../services/api_service.dart';
// import '../utils/shared_constants.dart';
//
// class PayUPage extends StatefulWidget {
//   const PayUPage({Key? key}) : super(key: key);
//
//   @override
//   State<PayUPage> createState() => _PayUPageState();
// }
//
// class _PayUPageState extends State<PayUPage>
//     implements PayUCheckoutProProtocol {
//   late PayUCheckoutProFlutter _checkoutPro;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkoutPro = PayUCheckoutProFlutter(this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('PayU Checkout Pro'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             child: const Text("Start Payment"),
//             onPressed: () async {
//               try {
//                 _checkoutPro.openCheckoutScreen(
//                   payUPaymentParams: PayUParams.createPayUPaymentParams(),
//                   payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
//                 );
//               } catch (e) {
//                 print(e);
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   showAlertDialog(BuildContext context, String title, String content) {
//     Widget okButton = TextButton(
//       child: const Text("OK"),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(title),
//             content: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: new Text(content),
//             ),
//             actions: [okButton],
//           );
//         });
//   }
//
//   @override
//   generateHash(Map response) {
//     // Backend will generate the hash which you need to pass to SDK
//     // hashResponse: is the response which you get from your server
//
//     String hashResponse = "";
//     //Keep the salt and hash calculation logic in the backend for security reasons. Don't use local hash logic.
//     //Uncomment following line to test the test hash.
//     void generateOrderId(var lead_id, var amount) async {
//       try {
//         var result = await ApiService().postMethod(
//             baseUrl: APIConstants.getBaseUrl(uri: 'payuOrders'),
//             header: APIConstants.getApiHeader(
//                 prefs.getString(SharedConstants.TOKEN) ?? ''),
//             body: {
//               "amount": amount.toString(),
//               "product_info": "Repayment",
//               "customer_name": prefs.getString(SharedConstants.NAME) ?? "",
//               "customer_email": prefs.getString(SharedConstants.EMAIL),
//               "customer_mobile": prefs.getString(SharedConstants.MOBILE),
//               "customer_address": prefs.getString(SharedConstants.CITY) ?? "",
//               "udf1": "test1",
//               "udf2": "test2",
//               "udf3": "test3",
//               "udf4": "test4",
//               "udf5": lead_id
//             });
//
//         if (result != null) {
//           if (result['Status'].toString() == "1") {
//             hashResponse = result['parameters']['hash'].toString();
//           } else {
//             ShortMessage.toast(title: result['Message'].toString());
//           }
//         }
//       } catch (e) {
//         print(e);
//       }
//     }
//
//     _checkoutPro
//         .hashGenerated(hash: {PayUHashConstantsKeys.hashName: hashResponse});
//   }
//
//   @override
//   onPaymentSuccess(dynamic response) {
//     showAlertDialog(context, "onPaymentSuccess", response.toString());
//   }
//
//   @override
//   onPaymentFailure(dynamic response) {
//     showAlertDialog(context, "onPaymentFailure", response.toString());
//   }
//
//   @override
//   onPaymentCancel(Map? response) {
//     showAlertDialog(context, "onPaymentCancel", response.toString());
//   }
//
//   @override
//   onError(Map? response) {
//     showAlertDialog(context, "onError", response.toString());
//   }
// }
//
// class PayUTestCredentials {
//   //Find the test credentials from dev guide: https://devguide.payu.in/flutter-sdk-integration/getting-started-flutter-sdk/mobile-sdk-test-environment/
//   static const merchantKey = "Ttbv1z"; // Add you Merchant Key
//   static const iosSurl =
//       "https://api.suryaloan.co.in/Api/CustomerDetails/payUPaymentCheckout";
//   static const iosFurl =
//       "https://api.suryaloan.co.in/Api/CustomerDetails/payUPaymentCheckout";
//   static const androidSurl =
//       "https://api.suryaloan.co.in/Api/CustomerDetails/payUPaymentCheckout";
//   static const androidFurl =
//       "https://api.suryaloan.co.in/Api/CustomerDetails/payUPaymentCheckout";
//
//   static const merchantAccessKey = ""; //Add Merchant Access Key - Optional
//   static const sodexoSourceId = ""; //Add sodexo Source Id - Optional
// }
//
// //Pass these values from your app to SDK, this data is only for test purpose
// class PayUParams {
//   static Map createPayUPaymentParams() {
//     var siParams = {
//       PayUSIParamsKeys.isFreeTrial: true,
//       PayUSIParamsKeys.billingAmount: '1',
//       //Required
//       PayUSIParamsKeys.billingInterval: 1,
//       //Required
//       PayUSIParamsKeys.paymentStartDate: '2023-10-26',
//       //Required
//       PayUSIParamsKeys.paymentEndDate: '2023-10-26',
//       //Required
//       PayUSIParamsKeys.billingCycle: //Required
//           'daily',
//       //Can be any of 'daily','weekly','yearly','adhoc','once','monthly'
//       PayUSIParamsKeys.remarks: 'Test SI transaction',
//       PayUSIParamsKeys.billingCurrency: 'INR',
//       PayUSIParamsKeys.billingLimit: 'ON',
//       //ON, BEFORE, AFTER
//       PayUSIParamsKeys.billingRule: 'MAX',
//       //MAX, EXACT
//     };
//
//     var additionalParam = {
//       PayUAdditionalParamKeys.udf1: "udf1",
//       PayUAdditionalParamKeys.udf2: "udf2",
//       PayUAdditionalParamKeys.udf3: "udf3",
//       PayUAdditionalParamKeys.udf4: "udf4",
//       PayUAdditionalParamKeys.udf5: "udf5",
//       PayUAdditionalParamKeys.merchantAccessKey:
//           PayUTestCredentials.merchantAccessKey,
//       PayUAdditionalParamKeys.sourceId: PayUTestCredentials.sodexoSourceId,
//     };
//
//     var spitPaymentDetails = {
//       "type": "absolute",
//       "splitInfo": {
//         PayUTestCredentials.merchantKey: {
//           "aggregatorSubTxnId": "1234567540099887766650091",
//           //unique for each transaction
//           "aggregatorSubAmt": "1"
//         }
//       }
//     };
//
//     var payUPaymentParams = {
//       PayUPaymentParamKey.key: PayUTestCredentials.merchantKey,
//       PayUPaymentParamKey.amount: "1",
//       PayUPaymentParamKey.productInfo: "Info",
//       PayUPaymentParamKey.firstName: "Abc",
//       PayUPaymentParamKey.email: "test@gmail.com",
//       PayUPaymentParamKey.phone: "",
//       PayUPaymentParamKey.ios_surl: PayUTestCredentials.iosSurl,
//       PayUPaymentParamKey.ios_furl: PayUTestCredentials.iosFurl,
//       PayUPaymentParamKey.android_surl: PayUTestCredentials.androidSurl,
//       PayUPaymentParamKey.android_furl: PayUTestCredentials.androidFurl,
//       PayUPaymentParamKey.environment: "1",
//       //0 => Production 1 => Test
//       PayUPaymentParamKey.userCredential: null,
//       //Pass user credential to fetch saved cards => A:B - Optional
//       PayUPaymentParamKey.transactionId:
//           DateTime.now().millisecondsSinceEpoch.toString(),
//       //DateTime.now().millisecondsSinceEpoch.toString()
//       PayUPaymentParamKey.additionalParam: additionalParam,
//       PayUPaymentParamKey.enableNativeOTP: true,
//       PayUPaymentParamKey.splitPaymentDetails: json.encode(spitPaymentDetails),
//       PayUPaymentParamKey.userToken: "",
//       //Pass a unique token to fetch offers. - Optional
//     };
//
//     return payUPaymentParams;
//   }
//
//   static Map createPayUConfigParams() {
//     var paymentModesOrder = [
//       {"Wallets": "PHONEPE"},
//       {"UPI": "TEZ"},
//       {"Wallets": ""},
//       {"EMI": ""},
//       {"NetBanking": ""},
//     ];
//
//     var cartDetails = [
//       {"GST": "5%"},
//       {"Delivery Date": "25 Dec"},
//       {"Status": "In Progress"}
//     ];
//     var enforcePaymentList = [
//       {"payment_type": "CARD", "enforce_ibiboCode": "UTIBENCC"},
//     ];
//
//     var customNotes = [
//       {
//         "custom_note": "Its Common custom note for testing purpose",
//         "custom_note_category": [
//           PayUPaymentTypeKeys.emi,
//           PayUPaymentTypeKeys.card
//         ]
//       },
//       {
//         "custom_note": "Payment options custom note",
//         "custom_note_category": null
//       }
//     ];
//
//     var payUCheckoutProConfig = {
//       PayUCheckoutProConfigKeys.primaryColor: "#4994EC",
//       PayUCheckoutProConfigKeys.secondaryColor: "#FFFFFF",
//       PayUCheckoutProConfigKeys.merchantName: "PayU",
//       PayUCheckoutProConfigKeys.merchantLogo: "logo",
//       PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
//       PayUCheckoutProConfigKeys.showExitConfirmationOnPaymentScreen: true,
//       PayUCheckoutProConfigKeys.cartDetails: cartDetails,
//       PayUCheckoutProConfigKeys.paymentModesOrder: paymentModesOrder,
//       PayUCheckoutProConfigKeys.merchantResponseTimeout: 30000,
//       PayUCheckoutProConfigKeys.customNotes: customNotes,
//       PayUCheckoutProConfigKeys.autoSelectOtp: true,
//       // PayUCheckoutProConfigKeys.enforcePaymentList: enforcePaymentList,
//       PayUCheckoutProConfigKeys.waitingTime: 30000,
//       PayUCheckoutProConfigKeys.autoApprove: true,
//       PayUCheckoutProConfigKeys.merchantSMSPermission: true,
//       PayUCheckoutProConfigKeys.showCbToolbar: true,
//     };
//     return payUCheckoutProConfig;
//   }
// }
