import '../exports/exports.dart';
import 'package:intl/intl.dart';

var navigatorKey = GlobalKey<NavigatorState>();
BuildContext context = navigatorKey.currentContext!;
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

void showAdaptive(Widget page) {
  showAdaptiveDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
    builder: (context) => Dialog(child: page),
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

void showLoader({required String text}) {
  showAdaptiveDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (context) => AlertDialog.adaptive(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    ),
  );
}
