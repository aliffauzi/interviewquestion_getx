import 'package:get/route_manager.dart';
import 'binding/binding.dart';
import 'resource/routes.dart';
import 'ui/page/page.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: firstLaunchRoute,
        page: () => SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: onBoardingRoute,
        page: () => OnBoardingPage(),
        binding: OnBoardingBinding()),
    GetPage(name: loginRoute, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: signUpRoute, page: () => SignUpPage(), binding: SignUpBinding()),
    GetPage(
        name: forgotPasswordRoute,
        page: () => ForgotPasswordPage(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: changePasswordRoute,
        page: () => ChangePasswordPage(),
        binding: ChangePasswordBinding()),
    GetPage(name: homeRoute, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: interviewQuestionRoute,
        page: () => InterviewQuestionPage(),
        binding: InterviewQuestionBinding()),
    GetPage(name: contactUsRoute, page: () => ContactUsPage()),
    GetPage(
        name: freeCodeRoute,
        page: () => FreeCodePage(),
        binding: FreeCodeBinging()),
    GetPage(name: freeCodeDetailRoute, page: () => FreeCodeDetailPage()),
    GetPage(name: technologyDetailRoute, page: () => TechnologyDetailPage()),
    GetPage(name: screenshotRoute, page: () => ScreenShotPage(), binding: ScreenShotBinding())
  ];
}
