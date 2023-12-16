import '../exports/exports.dart';
import 'package:intl/intl.dart';

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

String getTabLabel(DateTime date) {
  String stringDate = DateFormat('EEE d MMM').format(date);
  String currentDate = DateFormat('EEE d MMM').format(DateTime.now());
  // Customize the logic to determine the label based on the relation to the current date
  if (stringDate.split(" ").first == currentDate.split(" ").first &&
      stringDate.split(" ")[1] == currentDate.split(" ")[1]) {
    return 'Today';
  } else if (int.parse(stringDate.split(" ")[1]) ==
      (int.parse(currentDate.split(" ")[1]) - 1)) {
    return 'Yesterday';
  } else if (int.parse(stringDate.split(" ")[1]) ==
      (int.parse(currentDate.split(" ")[1]) + 1)) {
    return 'Tomorrow';
  } else {
    return DateFormat('EEE d MMM').format(date);
  }
}
