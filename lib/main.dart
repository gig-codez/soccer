/// Sports chat app
/// Github username: Mugamba669
/// Name: Mugamba Bruno
/// Date: 03/11/2023

import 'package:flutter/services.dart';
import 'package:samba_stats/controllers/match_date_controller.dart';
import '/theme/Theme.dart';

import '/exports/exports.dart';
import 'controllers/league_controller.dart';
import 'controllers/team_controller.dart';

void main() async {
  // Ensuring that all widgets are properly assembled.
  WidgetsFlutterBinding.ensureInitialized();
  // Rendering the app in full screen mode.
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [],
  );
  // prevent app from changing to landscape
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
// styling to the top and bottom navigation bars in full screen mode.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black12,
    ),
  );
  // main entry point for the app.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataController(),
        ),
        ChangeNotifierProvider(
          create: (_) => TeamController(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoaderController(),
        ),
        ChangeNotifierProvider(
          create: (_) => LeagueController(),
        ),
        ChangeNotifierProvider(
          create: (_) => MatchDateController(),
        ),
      ],
      child: Consumer<AppController>(
        builder: (context, controller, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: Routes.splash,
            debugShowCheckedModeBanner: false,
            themeMode: controller.mode,
            routes: Routes.routes,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
          );
        },
      ),
    ),
  );
}
