import '/exports/exports.dart';

class AppController with ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleDarkMode(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}