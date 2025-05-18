//import 'package:food_app/view/entry_point.dart';
//import 'package:food_app/view/home/home_screen.dart';
import 'package:foodly_ui/binding.dart';
import 'package:foodly_ui/view/Meal/meal_screen.dart';
import 'package:foodly_ui/view/location/add_location_screen.dart';
import 'package:foodly_ui/view/location/location_screen.dart';
import 'package:foodly_ui/view/order/order_screen.dart';
import 'package:foodly_ui/view/profile/profile_screen.dart';
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
import '../view/order/order_details_screen.dart';
import '../view/order_summary/order_summary_screen.dar.dart';
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
  static const String AddlocationScreen = "/addlocationScreen";
  static const String orderSummary="/orderSummary";
  static const String profile="/profile";
  static const String order="/order";
  static const String orderDetailScreen='/orderDetailScreen';


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
    GetPage(name: ScreenName.cartScreen, page: () => const CartScreen()),
    GetPage(
      name: ScreenName.orderSummary,
      page: () => const OrderSummaryScreen(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: ScreenName.locationScreen,
      page: () => const LocationScreen(),
      middlewares: [
        AuthMiddleware(),
        //LocationMiddleware(),
      ],
    ),

    GetPage(
      name: ScreenName.AddlocationScreen,
      page: () => const AddLocationScreen(),
      middlewares: [
        AuthMiddleware(),
        //LocationMiddleware(),
      ],
    ),
    GetPage(name: ScreenName.profile, page: () =>  ProfileScreen()),

    GetPage(
      name: ScreenName.order,
      page: () =>OrderScreen(),
      middlewares: [
        AuthMiddleware(),
        ],
    ),
    GetPage(
      name: ScreenName.orderDetailScreen,
      page: () => OrderDetailsScreen(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),

  ];

  get getRout => _setPAges;
}
