import 'package:flutter/material.dart';
import '../../presentation/views/main_screens.dart';
import '../../presentation/views/splash_screen.dart';
import '../../presentation/views/login_screen.dart';
import '../../presentation/views/signup_screen.dart';

import '../../config/router/routes_name.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  RoutesName.loginRoute: (context) => LoginScreen(),
  RoutesName.signupRoute: (context) => SignupScreen(),
  RoutesName.mainRoute: (context) => const MainScreens(),
  RoutesName.splashRoute: (context) => const SplashScreen(),
};
