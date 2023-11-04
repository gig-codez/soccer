import 'package:flutter/services.dart';

import '/exports/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black38,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppController(),
        ),
      ],
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: Routes.routes,
        theme: ThemeData.light().copyWith(
          drawerTheme: const DrawerThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Colors.white,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 247, 7, 127),
          ),
          primaryColor: const Color.fromARGB(255, 247, 7, 127),
          useMaterial3: true,
        ),
      ),
    ),
  );
}
