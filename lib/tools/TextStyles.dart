// ignore_for_file: file_names

import '/exports/exports.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle getTitleStyle() {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }

  TextStyle getDescriptionStyle() {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[300]
          : Colors.black54,
    );
  }

  TextStyle getRegularStyle() {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.blueAccent[900],
    );
  }

  TextStyle getBoldStyle() {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }
}
