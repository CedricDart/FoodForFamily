import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_for_family/common/constants/theme.dart';
import 'package:food_for_family/common/services/analytics_service.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:food_for_family/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'common/services/language_service.dart';
import 'common/utils/route_generator.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();
final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LanguageChangeProvider())],
      child: Builder(
        builder: (context) => MaterialApp(
          locale: Provider.of<LanguageChangeProvider>(context).currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'FoodForFamily',
          theme: ThemeStyles.lightTheme,
          initialRoute: routeSplash,
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorObservers: [routeObserver, locator<AnalyticsService>().getAnalyticsObserver()],
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
