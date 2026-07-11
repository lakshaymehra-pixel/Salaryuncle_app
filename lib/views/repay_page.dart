import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepayPage extends StatelessWidget {
  const RepayPage({super.key});

  @override
  Widget build(BuildContext context) {

    var webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://salarytopup.com/repay-loan')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://salarytopup.com/repay-loan'));
    return Scaffold(
      // appBar: CustomAppbar(context: context,title: 'Repay Loan'),
      body: Container(
        child: WebViewWidget(controller:webViewController ),
      ),
    );
  }
}
