import 'package:buy_me/routes/app_routes.dart';
import 'package:buy_me/ui/auth_screen/Auth.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/forgot_password_screen.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_binding.dart';
import 'package:buy_me/ui/auth_screen/sign_in_screen/sign_in_screen.dart';
import 'package:buy_me/ui/auth_screen/sign_up_screen/sign_up_binding.dart';
import 'package:buy_me/ui/auth_screen/sign_up_screen/sign_up_fill_screen.dart';
import 'package:buy_me/ui/auth_screen/sign_up_screen/sign_up_screen.dart';
import 'package:buy_me/ui/bookmark_screen/bookmark_binding.dart';
import 'package:buy_me/ui/bookmark_screen/bookmark_screen.dart';
import 'package:buy_me/ui/payment_screen/add_credit_card_scren/add_credit_card_screen.dart';
import 'package:buy_me/ui/cart_screen/cart_screen.dart';
import 'package:buy_me/ui/home/detail_home_screen.dart';
import 'package:buy_me/ui/home/home_binding.dart';
import 'package:buy_me/ui/home/home_screen.dart';
import 'package:buy_me/ui/home/tab_controller_screen.dart';
import 'package:buy_me/ui/home/write_review_screen/write_review_screen.dart';
import 'package:buy_me/ui/on_boarding_screen/on_boarding_screen.dart';
import 'package:buy_me/ui/payment_screen/payment_binding.dart';
import 'package:buy_me/ui/payment_screen/payment_screen.dart';
import 'package:buy_me/ui/profile_screen/edit_profile_screen.dart';
import 'package:buy_me/ui/profile_screen/profile_screen.dart';
import 'package:buy_me/ui/search_screen/search_screen.dart';
import 'package:buy_me/ui/splash_screen/splash_binding.dart';
import 'package:buy_me/ui/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.homeScreen,
      binding: HomeBinding(),
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.splashScreen,
      binding: SplashBinding(),
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onBoardingScreen,
      binding: HomeBinding(),
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: Routes.bookMarkScreen,
      binding: BookmarkBinding(),
      page: () => BookmarkScreen(),
    ),
    GetPage(
      name: Routes.detailHomeScreen,
      binding: HomeBinding(),
      page: () => DetailHomeScreen(),
    ),
    GetPage(
      name: Routes.writeReviewScreen,
      binding: HomeBinding(),
      page: () => const WriteReviewScreen(),
    ),
    GetPage(
      name: Routes.cartScreen,
      binding: HomeBinding(),
      page: () => CartScreen(),
    ),
    GetPage(
      name: Routes.searchScreen,
      binding: HomeBinding(),
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: Routes.tab_controller_screen,
      binding: HomeBinding(),
      page: () => const TabControllerScreen(),
    ),
    GetPage(
      name: Routes.signInScreen,
      binding: SignInBinding(),
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      binding: SignUpBinding(),
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.signUpFillScreen,
      binding: SignUpBinding(),
      page: () => const SignUpFillScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordScreen,
      binding: SignInBinding(),
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.authScreen,
      binding: SignInBinding(),
      page: () => const AuthScreen(),
    ),
    GetPage(
      name: Routes.profileScreen,
      binding: HomeBinding(),
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.editProfileScreen,
      binding: HomeBinding(),
      page: () => EditProfileScreen(),
    ),GetPage(
      name: Routes.paymentScreen,
      binding: PaymentBindings(),
      page: () => PaymentScreen(),
    ),GetPage(
      name: Routes.addNewCardScreen,
      binding: PaymentBindings(),
      page: () => AddCreditCardScreen(),
    ),
  ];
}
