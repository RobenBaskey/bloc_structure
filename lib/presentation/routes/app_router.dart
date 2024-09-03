import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/login/login_page.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/routes/route_names.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.init:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
    }
  }
}
