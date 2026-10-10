import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/show_score_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/color_constants.dart';
import '../utils/shared_constants.dart';

class ReportPage extends GetView<ShowScoreController> {
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    var webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              controller.loading.value = false;
            }
          },
          onPageStarted: (String url) {
            controller.loading.value = true;
          },
          onPageFinished: (String url) {
            controller.loading.value = false;
          },
          // onHttpError: (HttpResponseError error) {
          //   controller.loading.value = false;
          // },
          onWebResourceError: (WebResourceError error) {
            controller.loading.value = false;
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://salaryuncle.com/viewCustomerCibilPDF/${prefs.getString(SharedConstants.CIBIL_ID)}'));

    return Obx(() {
      return Scaffold(
        appBar: CustomAppbar(
          context: context,
          title: "CIBIL Report",
        ),
        body: controller.loading.value
            ? Center(
                child: SpinKitFadingCircle(
                size: 44,
                color: ColorConstants.primary,
              ))
            : WebViewWidget(controller: webViewController),
      );
    });
  }
}
