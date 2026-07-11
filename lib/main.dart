import 'dart:io';
import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/routes/page_routes.dart';
import 'package:tejas_loan/services/api_constant/api_constants.dart';
import 'package:tejas_loan/services/api_service.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/geo_locator.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:tejas_loan/utils/local_notification.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:tejas_loan/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'binding/connectivity_binding.dart';
import 'controller/theme_controller.dart';

late SharedPreferences prefs;
final globalNavigatorKey = GlobalKey<NavigatorState>();
// AppsflyerSdk? appsflyerSdk;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.grey.withOpacity(0.5),
    ),
  );
  prefs = await SharedPreferences.getInstance();

  // try {
  //   await setupAppFlyer();
  //   await getInstallReferrerData();
  // } catch (e) {
  //   debugPrint("APPFLYER ERROR$e");
  // }
  try {
    firebaseIntialize();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // prefs.setBool(SharedConstants.ISLOGIN, false);
  // prefs.setString(SharedConstants.PANCARD, "BMBPP1565P");
  // prefs.setString(SharedConstants.PROFILE_ID, "BDcPaQE5VDkDZA--");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // precacheImage(AssetImage(ImageConstants.logo), context);
    precacheImage(const AssetImage(ImageConstants.logo_gif_light), context);
    precacheImage(const AssetImage(ImageConstants.logo_gif), context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final ThemeController themeController = Get.put(ThemeController());
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          navigatorKey: globalNavigatorKey,
          debugShowCheckedModeBanner: APIConstants.isModeDevelopment(),
          themeMode: ThemeMode.light,
          theme: ColorConstants.themeLight,
          darkTheme: ColorConstants.themeDark,
          title: '${SharedConstants.Brand_Name}',
          // Bump all text ~18% bigger app-wide (fixes small responsive_sizer .sp fonts),
          // and cap the user's system font scale so layouts don't overflow.
          builder: (context, child) {
            final mq = MediaQuery.of(context);
            final scale = mq.textScaler.scale(1.0).clamp(1.0, 1.2) * 1.18;
            return MediaQuery(
              data: mq.copyWith(textScaler: TextScaler.linear(scale)),
              child: child ?? const SizedBox.shrink(),
            );
          },
          home: SplashScreen(),
          initialBinding: ControllerBinding(),
          getPages: GetPages().routes,
        );
    });
  }
}

void firebaseIntialize() async {
  try {
    await Permission.notification.request();
  } catch (e) {
    debugPrint(e.toString());
  }
  try {
    await GeoLocation().determinePosition().then((value) =>
        prefs.setString(SharedConstants.LATLONG, "${value.latitude.toString()},${value.longitude.toString()}"));
  } catch (e) {
    prefs.setString(SharedConstants.LATLONG, "0.0,0.0");
    if (kDebugMode) {
      print(e);
    }
  }
  LocalNotificationService localNotificationService = LocalNotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getDeviceTokenToSendNotification()
      .then((value) => prefs.setString(SharedConstants.FCM_TOKEN, value.toString()));
  if (kDebugMode) {
    print("FCM Token :==>${prefs.getString(SharedConstants.FCM_TOKEN)} & ${prefs.getString(SharedConstants.LATLONG)}");
  }
  localNotificationService.firebaseInit(globalNavigatorKey.currentContext);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<String> getDeviceTokenToSendNotification() async {
  String? deviceToken = await FirebaseMessaging.instance.getToken();
  return deviceToken.toString();
} // ...

Future<void> getInstallReferrerData() async {
  try {
    final referrerDetails = await AndroidPlayInstallReferrer.installReferrer;

    if (referrerDetails != null) {
      print("Install Referrer: ${referrerDetails.installReferrer}");
      var utm_source = extractParameter(referrerDetails.installReferrer ?? "mnmn", 'utm_source');
      var utm_campaign = extractParameter(referrerDetails.installReferrer ?? "kjbkad", 'utm_campaign');
      var utm_campaign_id = extractParameter(referrerDetails.installReferrer ?? "kjdbak", 'utm_campaign_id');
      prefs.setString(SharedConstants.UTM_SOURCE, utm_source ?? "");
      prefs.setString("utm_campaign", utm_campaign ?? "");
      prefs.setString("utm_campaign_id", utm_campaign_id ?? "");
    } else {
      print("No referrer data available.");
    }
  } catch (e) {
    print("Error getting referrer: $e");
  }
}

// Helper function to extract UTM parameters
String? extractParameter(String referrer, String key) {
  Uri uri = Uri.parse("https://dummy.com?$referrer"); // Treat referrer as query string
  return uri.queryParameters[key];
}

// Future setupAppFlyer() async {
//   Map<String, Object> appsFlyerOptions = {
//     "afDevKey": "fupfvH2AJ3JwqVvW9z2747",
//     "afAppId": Platform.isIOS ? "6503283983" : "com.suryaloan.suryaloan",
//   };
//   debugPrint("onAppOpenAttribution data: ");
//
//   appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
//   appsflyerSdk?.initSdk(
//     registerConversionDataCallback: true,
//     // Set to true to get attribution data
//     registerOnAppOpenAttributionCallback: true,
//     // Set to true for deep linking
//     registerOnDeepLinkingCallback: true,
//     // Enable for deep linking
//   );
//   appsflyerSdk?.onAppOpenAttribution((res) {
//     debugPrint("onAppOpenAttribution data: $res"); // Handle deep link here
//   });
//
//   appsflyerSdk?.onDeepLinking((deepLinkResult) {
//     if (kDebugMode) {
//       print("DeepLink Result: ${deepLinkResult.status}");
//     }
//
//     if (deepLinkResult.status == Status.FOUND) {
//       final data = deepLinkResult.deepLink;
//       handleDeeplink(data);
//     }
//   });
// }

void handleDeeplink(DeepLink? data) {
  final page = data!.clickEvent['path'] ?? "/";

  if (kDebugMode) {
    print("DeepLink Result: $page");
  }

  Future.delayed(const Duration(seconds: 4), () => Get.offAllNamed(page, arguments: data!.clickEvent['link']));
  // Navigator.push(context, MaterialPageRoute(builder: (_) => OfferPage(id: data['id'])));
}

checkVersion(BuildContext context) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  if (APIConstants.isModeDevelopment()) if (kDebugMode) {
    print("App Name: $appName, Package Name: $packageName, Version: $version, Build Number: $buildNumber");
  }

  var result = await ApiService().postMethod(
      baseUrl: APIConstants.getBaseUrl(uri: "checkInstantAppVersion"),
      body: {"version": version, "app_name": "SOT"},
      header: APIConstants.apiHeader1);
  if (result != null) {
    if (result['Status'].toString() == "1") {
      // ShortMessage.toast(title: result['Message'].toString());
      // Get.back();
    } else {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Older Version Detected",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
              content:
                  Text(result['Message'].toString(), style: const TextStyle(color: Color(ColorConstants.primaryColor))),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Later", style: TextStyle(color: Color(ColorConstants.tertiaryColor)))),
                TextButton(
                    onPressed: () {
                      Uri storeLink = Uri.parse('');
                      if (GetPlatform.isIOS) {
                        storeLink = Uri.parse('https://apps.apple.com/in/app/suryaloan/id${SharedConstants.IOS_App_Id}');
                      } else {
                        storeLink =
                            Uri.parse('https://play.google.com/store/apps/details?id=${SharedConstants.ARD_Package_Name}');
                      }
                      launchUrl(storeLink, mode: LaunchMode.externalApplication);
                    },
                    child: const Text("OK", style: TextStyle(color: Color(ColorConstants.tertiaryColor)))),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.sp),
              ),
              elevation: 15,
              shadowColor: Colors.grey,
            );
          });
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("FCM Token :==>${message.notification!.title}");
  // if (Platform.isAndroid) {
  //   if (message.notification!.android!.link.toString().isNotEmpty) {
  //   //   UrlLauncher().launchURL(
  //   //       url: message.notification!.android!.link.toString(),
  //   //       mode: LaunchMode.externalApplication);
  //   }
  // Get.offAllNamed(RoutesName.dashboard)
  LocalNotificationService.createanddisplaynotification(message);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
