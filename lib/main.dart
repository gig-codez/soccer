/// Sports chat app
/// Github username: Mugamba669
/// Name: Mugamba Bruno
/// Date: 03/11/2023

import 'package:flutter/services.dart';
import 'package:soccer/theme/Theme.dart';
import 'package:soccer/tools/tools.dart';

import '/exports/exports.dart';

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
      ],
      child: Consumer<AppController>(
        builder: (context, controller, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: Routes.splash,
            routes: Routes.routes,
            theme: controller.isDarkMode ? Themes.darkTheme : Themes.lightTheme,
          );
        },
      ),
    ),
  );
}
