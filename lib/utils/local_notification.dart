// import 'package:badges/badges.dart' as ;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    const InitializationSettings initializationSettings =
        InitializationSettings(android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    if (GetPlatform.isAndroid) {
      _notificationsPlugin.initialize(
        initializationSettings,
      );
    }
  }

  static bool showNotification = true;

  static void createanddisplaynotification(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    try {
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            SharedConstants.Brand_Name,
            "Important",
            icon: "@mipmap/ic_launcher",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentBanner: true, presentSound: true));
      if (LocalNotificationService.showNotification == true) {
        LocalNotificationService.showNotification = false;
        // if (message.notification!.android!.link.toString().isNotEmpty &&
        //     message.notification!.android!.link.toString() != "") {
        //   // Get.toNamed(RoutesName.mapMyIndiaScreen,
        //   //     arguments: ["20.211301", "76.840244", "Emergency"]);
        //   //   UrlLauncher().launchURL(
        //   //       url: message.notification!.android!.link.toString(),
        //   //       mode: LaunchMode.inAppWebView);
        // }
        if (GetPlatform.isIOS) {
          foreground();
        }
        // print('Notification :==> ${message.notification!.android!.toMap()}\nid:==> ${id}');
        await _notificationsPlugin.show(
          id,
          message.notification?.title,
          message.notification?.body,
          notificationDetails,
          // payload: message.notification?.android?.imageUrl.toString(),
        );
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      Future.delayed(const Duration(seconds: 3), () {
        LocalNotificationService.showNotification = true;
      });
    }
  }

  firebaseInit(var context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    FirebaseMessaging.onMessage.listen(
      (message) {
        // OrderHistoryModel orderItemNotificationModel =
        //     OrderHistoryModel.fromJson(message.data);
        // print(
        //     "jhvjhgkhjfjh fkhjg kgh kj :==> onMessage ${orderItemNotificationModel.toJson().toString()}");
        if (message.messageId!.isNotEmpty) {
          if (message.notification!.body!.isNotEmpty) {
            // showDialogBox(orderItemNotificationModel, context);
            LocalNotificationService.createanddisplaynotification(message);
          }
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.messageId!.isNotEmpty) {
          if (message.notification!.body!.isNotEmpty) {
            // if (message.notification!.android!.link.toString().isNotEmpty) {
            //   UrlLauncher().launchURL(
            //       url: message.notification!.android!.link.toString(),
            //       mode: LaunchMode.externalApplication);
            // }
            LocalNotificationService.createanddisplaynotification(message);
          }
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage((message) async {
      if (message.messageId!.isNotEmpty) {
        if (message.notification!.body!.isNotEmpty) {
          // if (message.notification!.android!.link.toString().isNotEmpty) {
          //   UrlLauncher().launchURL(
          //       url: message.notification!.android!.link.toString(),
          //       mode: LaunchMode.externalApplication);
          // }
          // Get.offAllNamed(RoutesName.dashboard);
          LocalNotificationService.createanddisplaynotification(message);
        }
      }
    });
  }
}

Future foreground() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
    badge: true,
  );
}

Future<String> getDeviceTokenToSendNotification() async {
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true);
  var s = await messaging.getToken();
  return s.toString();
}
