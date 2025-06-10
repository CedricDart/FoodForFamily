import 'package:flutter/cupertino.dart';
import 'package:food_for_family/common/components/in_app_webview.dart';
import 'package:food_for_family/features/home/home_screen.dart';
import 'package:food_for_family/features/splash/splash_screen.dart';

const routeSplash = '/splash';
const routeOnboardingLanguage = '/onboarding/language';
const routeHome = '/home';
const routeWebView = '/webView';
const routeMaintenance = '/maintenance';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplash:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(),
        );
      case routeHome:
        final arg = settings.arguments as HomeScreenArguments;
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(arguments: arg),
        );
      case routeWebView:
        final webViewArgs = settings.arguments as InAppWebViewArguments;
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => InAppWebView(title: webViewArgs.title, url: webViewArgs.url),
        );
    }
    return null;
  }
}
