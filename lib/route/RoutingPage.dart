//import 'package:food_app/view/entry_point.dart';
//import 'package:food_app/view/home/home_screen.dart';
import 'package:foodly_ui/binding.dart';
import 'package:foodly_ui/view/Meal/meal_screen.dart';
import 'package:foodly_ui/view/location/location_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:foodly_ui/view/entry_point.dart';
import 'package:foodly_ui/view/home/home_screen.dart';

import '../middleware/auth_mddleware.dart';
import '../middleware/location_middleware.dart';
import '../view/auth/sign_in_screen.dart';
import '../view/auth/sign_up_screen.dart';
import '../view/cart/cart_screen.dart';
import '../view/details/details_screen.dart';
import '../view/featured/featurred_screen.dart';
import '../view/splach_screen.dart';

class ScreenName {
  static const String splash = "/";
  static const String entryPoint = "/entryPoint";
  static const String homeScreen = "/homeScreen";
  static const String featuredScreen = "/featuredScreen";
  static const String detailsScreen = "/detailsScreen";
  static const String SingUpScreen = "/SingUpScreen";
  static const String SinginScreen = "/SingInScreen";
  static const String mealScreen = "/mealScreen";
  static const String cartScreen = "/cartScreen";
  static const String locationScreen = "/locationScreen";

}

class RoutingPage {
  final List<GetPage> _setPAges = [
    GetPage(name: ScreenName.splash, page: () => const SplachScreen()),
    GetPage(name: ScreenName.entryPoint, page: () => EntryPoint()),
    GetPage(name: ScreenName.homeScreen, page: () => const HomeScreen()),
    GetPage(name: ScreenName.featuredScreen, page: () => const FeaturedScreen()),
    GetPage(name: ScreenName.detailsScreen, page: () => const DetailsScreen()),
    GetPage(name: ScreenName.SingUpScreen, page: () => const SignUpScreen()),
    GetPage(name: ScreenName.SinginScreen, page: () => const SignInScreen()),
    GetPage(name: ScreenName.mealScreen, page: () => const MealScreen()),
    GetPage(
      name: ScreenName.cartScreen,
      page: () => const CartScreen(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: ScreenName.locationScreen,
      page: () => const LocationScreen(),
      middlewares: [
        AuthMiddleware(),
        LocationMiddleware(),
      ],
    ),

  ];

  get getRout => _setPAges;
}
