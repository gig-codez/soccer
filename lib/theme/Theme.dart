import '/exports/exports.dart';

class Themes {
  static DrawerThemeData drawerTheme = const DrawerThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    // backgroundColor: Colors.white,
  );
  static TextTheme textTheme = GoogleFonts.poppinsTextTheme();
// light theme
  static ThemeData lightTheme = ThemeData(
    drawerTheme: drawerTheme,
    textTheme: textTheme.apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
      decorationColor: Colors.black,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      background: Colors.white,
    ),
    primaryColor: primaryColor,
    useMaterial3: true,
  );
  // dark theme
  static ThemeData darkTheme = ThemeData(
    drawerTheme: drawerTheme,
    textTheme: textTheme.apply(
      displayColor: Colors.grey.shade300,
      bodyColor: Colors.grey.shade300,
      decorationColor: Colors.grey.shade300,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      background: Colors.black,
    ),
    primaryColor: primaryColor,
    useMaterial3: true,
  );
}
