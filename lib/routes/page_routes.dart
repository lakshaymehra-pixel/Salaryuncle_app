import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tejas_loan/binding/aadhaar_binding.dart';
import 'package:tejas_loan/binding/dashDetailBinding.dart';
import 'package:tejas_loan/binding/dashbroad_binding.dart';
import 'package:tejas_loan/binding/doc_binding.dart';
import 'package:tejas_loan/binding/loan_binding.dart';
import 'package:tejas_loan/binding/loging_binding.dart';
import 'package:tejas_loan/binding/occupation_binding.dart';
import 'package:tejas_loan/binding/pancar_binding.dart';
import 'package:tejas_loan/binding/personalDetail_binding.dart';
import 'package:tejas_loan/binding/preview_binding.dart';
import 'package:tejas_loan/binding/repayment_binding.dart';
import 'package:tejas_loan/binding/showScore_binding.dart';
import 'package:tejas_loan/binding/splash_binding.dart';
import 'package:tejas_loan/binding/status_binding.dart';
import 'package:tejas_loan/views/repayment_history_page.dart';
import 'package:tejas_loan/views/congrates_page.dart';
import 'package:tejas_loan/views/dash_detail_page.dart';
import 'package:tejas_loan/views/dashbroad_page.dart';
import 'package:tejas_loan/views/eligiblity_falied_page.dart';
import 'package:tejas_loan/views/employment_details.dart';
import 'package:tejas_loan/views/loan_status_page.dart';
import 'package:tejas_loan/views/onbroading_page.dart';
import 'package:tejas_loan/views/otp_screen.dart';
import 'package:tejas_loan/views/payment_failed_page.dart';
import 'package:tejas_loan/views/payment_success_page.dart';
import 'package:tejas_loan/views/personaldetail_page.dart';
import 'package:tejas_loan/views/preview_detail_page.dart';
import 'package:tejas_loan/views/privacy_policy_page.dart';
import 'package:tejas_loan/views/residenceDetails_page.dart';
import 'package:tejas_loan/views/terms_conditions_page.dart';
import 'package:tejas_loan/views/thankyou_page.dart';

import '../binding/bankDetails_binding.dart';
import '../routes/routes_names.dart';
import '../views/adhaar_page.dart';
import '../views/bank_detail_page.dart';
import '../views/incomeDetailPage.dart';
import '../views/loan_amount_page.dart';
import '../views/loging_page.dart';
import '../views/occupation_page.dart';
import '../views/pan_page.dart';
import '../views/registeration_page.dart';
import '../views/score_page.dart';
import '../views/splash_screen.dart';
import '../views/upload_doc_page.dart';

class GetPages {
  List<GetPage> routes = [
    GetPage(name: RoutesName.SplashScreen, page: () => SplashScreen(), binding: SplashBinding()),
    GetPage(
      name: RoutesName.RegisterScreen,
      page: () => RegisterPage(),
    ),
    GetPage(name: RoutesName.LoginScreen, page: () => const LogingPage(), binding: LogingBinding()),
    GetPage(name: RoutesName.OTPScreen, page: () => OtpScreen(), binding: LogingBinding()),
    GetPage(
      name: RoutesName.LoanSelect,
      page: () => LoanAmountPage(),
      binding: LoanBinding(),
    ),
    GetPage(
      name: RoutesName.LoanStatusScreen,
      page: () => LoanStatusScreen(),
      binding: StatusBinding(),
    ),
    GetPage(
      name: RoutesName.CongratesPage,
      page: () => CongratesPage(),
    ),
    GetPage(name: RoutesName.PanScreen, page: () => const PanDetailsPage(), binding: PanCardBinding()),
    GetPage(name: RoutesName.AadhaarScreen, page: () => AdhaarPage(), binding: AadhaarBinding()),
    GetPage(
      name: RoutesName.ScoreScreen,
      page: () => const ShowScorePage(),
      binding: ShowScoreBinding(),
    ),
    GetPage(
      name: RoutesName.BankScreen,
      page: () => const BankDetailPage(),
      binding: BankDetailsBinding(),
    ),
    GetPage(name: RoutesName.DocScreen, page: () => DocPage(), binding: DocBinding()),
    GetPage(
      name: RoutesName.OnbroadingPage,
      page: () => OnbroadingPage(),
    ),
    GetPage(name: RoutesName.OccupationScreen, page: () => const OccupationPage(), binding: OccupationBinding()),
    GetPage(
        name: RoutesName.ResidenceDetailsScreen, page: () => ResidenceDetailsPage(), binding: PersonalDetailBinding()),
    GetPage(
        name: RoutesName.PersonalDetailsScreen, page: () => PersonalDetailsPage(), binding: PersonalDetailBinding()),
    GetPage(name: RoutesName.IncomeDetailsScreen, page: () => IncomeDetailsPage(), binding: PersonalDetailBinding()),
    GetPage(
        name: RoutesName.EmploymentDetailsScreen,
        page: () => EmploymentDetailsPage(),
        binding: PersonalDetailBinding()),
    GetPage(name: RoutesName.RepayHisScreen, page: () => const RepaymentHistoryPage(), binding: RepaymentHistoryBinding()),
    GetPage(
      name: RoutesName.ThankyouScreen,
      page: () => const ThankyouPage(),
    ),
    GetPage(
      name: RoutesName.PreviewScreen,
      page: () => BasicDetailsCardApp(),
      binding: PreviewBinding(),
    ),
    GetPage(name: RoutesName.DashbroadScreen, page: () => DashbroadPage(), binding: DashbroadBinding()),
    GetPage(name: RoutesName.DashDetailScreen, page: () => DashDeatailPage(), binding: DashDetailBinding()),
    GetPage(
      name: RoutesName.PaymentFailedPage,
      page: () => const PaymentFailedPage(),
    ),
    GetPage(
      name: RoutesName.EligiblityFaliedPage,
      page: () => EligiblityFaliedPage(),
    ),
    GetPage(
      name: RoutesName.TermsAndConditionsPage,
      page: () => const TermsAndConditionsScreen(),
    ),
    GetPage(
      name: RoutesName.PrivacyPolicyPage,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: RoutesName.PaymentSuccessPage,
      page: () => const PaymentSuccessPage(),
    ),
  ];
}
