import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../routes/routes_names.dart';

/// In-app repayment WebView. Opened instead of `launchUrl(inAppWebView)` so the
/// user stays inside the app and always has a way back to the dashboard.
class RepayPage extends StatefulWidget {
  const RepayPage({super.key});

  @override
  State<RepayPage> createState() => _RepayPageState();
}

class _RepayPageState extends State<RepayPage> {
  late final WebViewController _controller;
  bool _loading = true;

  static const String _repayUrl = 'https://salaryuncle.com/repay-loan';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (_) {
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(_repayUrl));
  }

  /// Back inside the page's own history first, then out of the screen.
  Future<void> _handleBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return;
    }
    _exit();
  }

  void _exit() {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    } else {
      Get.offAllNamed(RoutesName.DashbroadScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        backgroundColor: ColorConstants.scaffoldLight,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.greenDeep,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: _handleBack,
          ),
          title: const Text('Repay Loan',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'Dashboard',
              icon: const Icon(Icons.home_rounded, color: Colors.white),
              onPressed: () => Get.offAllNamed(RoutesName.DashbroadScreen),
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ColorConstants.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
