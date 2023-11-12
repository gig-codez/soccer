import '/exports/exports.dart';

class AppController with ChangeNotifier {
  // SharedPreferences _prefs = SharedPreferences.getInstance();
  // AppController() {}
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool mode) {
    _isDarkMode = mode;
    notifyListeners();
  }
}
