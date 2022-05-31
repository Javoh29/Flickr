import 'package:flickr_app/ui/pages/img_view_page.dart';
import 'package:flickr_app/ui/pages/main_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const mainPage = '/';
  static const authPage = '/authPage';
  static const imgViewPage = '/imgViewPage';
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      switch (routeSettings.name) {
        case authPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const MainPage(),
          );
        case imgViewPage:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => ImgViewPage(args!['model']),
          );
        default:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const MainPage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainPage(),
      );
    }
  }
}
