import '../exports/exports.dart';

var navigatorKey = GlobalKey<NavigatorState>();

void showMessage({String msg = "", Color? color}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        msg,
      ),
    ),
  );
}

void showModalSheet(Widget page, {AnimationController? controller}) {
  showModalBottomSheet(
    showDragHandle: true,
    transitionAnimationController: controller,
    context: navigatorKey.currentContext!,
    builder: (context) => BottomSheet(
      animationController: controller,
      onClosing: () {},
      builder: (context) => page,
    ),
  );
}
