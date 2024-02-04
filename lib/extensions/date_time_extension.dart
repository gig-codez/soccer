import 'package:intl/intl.dart';

extension DateTimeUtil on DateTime {

    String formatedDate() {
    String stringDate = DateFormat('EEE d MMM').format(this);
    String currentDate = DateFormat('EEE d MMM').format(DateTime.now());
    // Customize the logic to determine the label based on the relation to the current date
    if (stringDate.split(" ").first == currentDate.split(" ").first &&
        stringDate.split(" ")[1] == currentDate.split(" ")[1] &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Today';
    } else if (int.parse(stringDate.split(" ")[1]) ==
            (int.parse(currentDate.split(" ")[1]) - 1) &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Yesterday';
    } else if (int.parse(stringDate.split(" ")[1]) ==
            (int.parse(currentDate.split(" ")[1]) + 1) &&
        (stringDate.split(" ").last == currentDate.split(" ").last)) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE d MMM').format(this);
    }
  }
}