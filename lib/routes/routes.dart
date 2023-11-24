import 'package:soccer/views/pages/sections/LeagueFixtures.dart';
import 'package:soccer/views/pages/sections/match_dates.dart';

import '/views/pages/sections/Fixtures.dart';
import '/views/pages/sections/Players.dart';
import '/views/pages/sections/leagues.dart';

import '../views/pages/sections/Teams.dart';
import '/exports/exports.dart';

class Routes {
  // routes definition
  static String splash = "/splash";
  static String onBoard = "/onBoard";
  static String createAccount = "/createAccount";
  static String completeProfile = "/completeProfile";
  static String login = "/login";
  static String home = "/home";
  static String settings = "/settings";
  static String notifications = "/notifications";
  static String teams = "/teams";
  static String leagues = "/leagues";
  static String fixtures = "/fixtures";
  static String fixturePage = "/fixture/Page";
  static String players = "/players";
  static String matchdates = "/matchdates";
  static BuildContext context = navigatorKey.currentState!.context;
  // routes merger
  static Map<String, Widget Function(BuildContext context)> routes = {
    onBoard: (context) => const OnBoardingScreen(),
    splash: (context) => const SplashScreen(),
    createAccount: (context) => const CreateAccount(),
    completeProfile: (context) => const CompleteUserProfile(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomePage(),
    settings: (context) => const GeneralSettings(),
    teams: (context) => const Teams(),
    fixtures: (context) => const LeagueFixtures(),
    leagues: (context) => const Leagues(),
    notifications: (context) => const Notifications(),
    players: (context) => const Players(),
    matchdates: (context) => const MatchDates(),
  };

  // routes methods
  static void popPage() {
    Navigator.of(context).pop();
  }

  static void pushPage(String route) {
    Navigator.of(context).pushNamed(route);
  }

  static void replacePage(Widget route) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => route, fullscreenDialog: true),
    );
  }

  static void removePage(String route) {
    Navigator.of(context).popAndPushNamed(route);
  }

  static void removeUntilPage(String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  static void animateToPage(Widget page, {type = 'fade'}) {
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
