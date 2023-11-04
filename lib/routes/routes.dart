import '/exports/exports.dart';

class Routes {
  // routes definition
  static String splash = "/splash";
  static String onBoard = "/onBoard";
  static String createAccount = "/createAccount";
  static String completeProfile = "/completeProfile";
  static String login = "/login";
  static String home = "/home";
  // routes merger
  static Map<String, Widget Function(BuildContext context)> routes = {
    onBoard: (context) => const OnBoardingScreen(),
    splash: (context) => const SplashScreen(),
    createAccount: (context) => const CreateAccount(),
    completeProfile: (context) => const CompleteUserProfile(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen()
  };

  // routes methods
  static void popPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushPage(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  static void replacePage(BuildContext context, String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  static void removePage(BuildContext context, String route) {
    Navigator.of(context).popAndPushNamed(route);
  }

  static void removeUntilPage(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  static void animateToPage(BuildContext context, Widget page,
      {type = 'fade'}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => type == 'scale'
            ? ScaleTransition(
                scale: animation,
                child: page,
              )
            : FadeTransition(
                opacity: animation,
                child: page,
              ),
      ),
    );
  }
}
