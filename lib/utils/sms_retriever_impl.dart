import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

/// Bridges the `smart_auth` plugin to Pinput's [SmsRetriever] interface so the
/// OTP boxes can auto-fill the code from an incoming SMS.
///
/// Uses the **SMS User Consent API** (`useUserConsentApi: true`): Android shows
/// a one-tap consent dialog for the incoming OTP SMS and, once allowed, the code
/// is extracted and filled automatically. This works with any OTP SMS format
/// (it does NOT require the 11-char app-hash that the SMS Retriever API needs),
/// which is important because the OTP is sent by the existing backend.
class SmsRetrieverImpl implements SmsRetriever {
  SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  bool get listenForMultipleSms => false;

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsCode(useUserConsentApi: true);
    if (res.succeed && res.codeFound) {
      return res.code;
    }
    return null;
  }

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }
}
