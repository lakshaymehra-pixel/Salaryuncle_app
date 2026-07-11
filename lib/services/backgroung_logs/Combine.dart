// import 'dart:convert';
//
// import 'package:call_log/call_log.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// import 'package:http/http.dart' as http;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tejas_loan/main.dart';
//
// import '../../models/models.dart';
// import '../../utils/shared_constants.dart';
// import 'Services.dart';
//
// Future<List<SmsMessage>> getMessages(var messages, SmsQuery query) async {
//   messages =
//       await query.querySms(kinds: [SmsQueryKind.inbox], count: 100, sort: true);
//   debugPrint('sms inbox messages: ${messages.length}');
//   return messages;
//   // await launchUrl(
//   //     Uri.parse(
//   //         "https://www.suryaloan.com/terms-and-conditions"),mode: LaunchMode.inAppWebView);
// }
//
// Future<void> requestPermissions() async {
//   // FlutterBackgroundService().invoke("stopService");
//
//   var status = await Permission.contacts.status;
//   var status2 = await Permission.phone.status;
//   var status3 = await Permission.notification.status;
//   var status4 = await Permission.sms.status;
//   var status5 = await Permission.location.status;
//   try {
//     if (!status.isGranted ||
//         !status2.isGranted ||
//         !status3.isGranted ||
//         !status4.isGranted ||
//         !status5.isGranted) {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.location,
//         Permission.contacts,
//         Permission.phone,
//         Permission.notification,
//         Permission.sms,
//       ].request().then((value) {
//         if (value[Permission.location]!.isGranted) {
//           Permission.locationAlways.request();
//         } else {
//           openAppSettings();
//         }
//         return value;
//       });
//     }
//   } catch (e) {
//     print(e);
//   }
// }
//
// Future<List<Contact>> loadContacts() async {
//   var contacts = <Contact>[];
//   if (await Permission.contacts.isGranted) {
//     contacts = await ContactsService.getContacts();
//
//     ContactsModel contactsModel = ContactsModel();
//     List<Contacts> contactsList = [];
//     for (var i = 0; i < contacts.length; i++) {
//       Contacts contact = Contacts();
//       contact.number = contacts[i].phones!.isNotEmpty
//           ? contacts[i].phones!.first.value ?? ''
//           : 'No phone number';
//       contact.name = contacts[i].displayName ?? 'No Name';
//       contactsList.add(contact);
//     }
//     contactsModel.contacts = contactsList;
//     contactsModel.leadId = leadId;
//     contactsModel.logType = '1';
//     print('contacts ==> ${contactsList.length}');
//
//     print("REQUEST==>${jsonEncode(contactsModel)}");
//
//     var headers = {'Content-Type': 'application/json'};
//
//     try {
//       print('IN');
//       http.Response response = await http.post(
//           Uri.parse(
//               'http://api.crm.suryaloan.in/Api/DevicePrivacyController/updateLogs'),
//           headers: headers,
//           body: jsonEncode(contactsModel));
//       print("RESPONSE==>" + await response.body);
//
//       if (response.statusCode == 200) {
//         print(await response.body);
//       } else {
//         print("ERROR==>" + response.reasonPhrase.toString());
//       }
//       print('OUT');
//     } catch (e) {
//       print('CATCH==>' + e.toString());
//     }
//   } else {
//     openAppSettings();
//   }
//   return contacts;
// }
//
// Future<Iterable<CallLogEntry>> loadCallLogs(
//     Iterable<CallLogEntry> callLists) async {
//   callLists = await CallLog.get();
//
//   var now = DateTime.now();
//   int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
//   callLists = await CallLog.query(
//     dateFrom: from,
//     dateTo: now.microsecondsSinceEpoch,
//   );
//
//   // print('CALL LOGS ==>: ${callLists.first.number}');
//   return callLists;
// }
//
// Future<bool> startService() async {
//   if (await Permission.contacts.isGranted && await Permission.sms.isGranted) {
//     print('true');
//
//     WidgetsFlutterBinding.ensureInitialized();
//     await initializeService();
//     // List<Contact> list = await loadContacts();
//     //
//     //
//     //   print('CONTACT ==> ${list[1].displayName}');
//
//     return true;
//   } else {
//     print(
//         'false${await Permission.contacts.isGranted} and ${await Permission.sms.isGranted}');
//
//     openAppSettings();
//
//     return false;
//
//     // requestPermissions();
//   }
// }
//
// Future<String?> getId() async {
//   var lead_id = await prefs.getString(SharedConstants.LEAD_ID) ?? '';
//   return lead_id; // unique ID on Android
// }
