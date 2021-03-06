import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_architecture/locator.dart';
import 'package:provider_architecture/ui/shared/app_colors.dart';
import 'package:provider_architecture/ui/shared/app_colors.dart' as prefix0;
import 'core/services/localstorage_service.dart';
import 'core/services/navigation_service.dart';
import 'ui/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await setupLocator();
    runApp(MyApp());
  } catch (error) {
    print('Locator setup has failed! ' + error.toString());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // STATUS BAR color
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColorDark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carfit',
      theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Quicksand',
          accentColor: prefix0.primaryColor),
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: _getStartupScreen(),
      onGenerateRoute: RR.generateRoute,
    );
  }

  String _getStartupScreen() {
    var localStorageService = locator<LocalStorageService>();

    if (!localStorageService.hasLoggedIn) {
      return RR.ONBOARDING;
    } else {
      return RR.MENU;
    }
  }
}
