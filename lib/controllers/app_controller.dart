import 'package:shared_preferences/shared_preferences.dart';

import '/exports/exports.dart';

class AppController with ChangeNotifier {
  // SharedPreferences _prefs = SharedPreferences.getInstance();
  ThemeMode _mode = ThemeMode.light;

  void setMode(ThemeMode mode) {
    _mode = mode;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(
        'theme',
        mode == ThemeMode.light
            ? 'light'
            : mode == ThemeMode.dark
                ? 'dark'
                : 'system',
      );
    });
    notifyListeners();
  }

// get prefs
  Future<void> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme') ?? '';
    if (theme == 'system') {
      _mode = ThemeMode.system;
    } else if (theme == 'dark') {
      _mode = ThemeMode.dark;
    } else {
      _mode = ThemeMode.light;
    }
    notifyListeners();
  }

// get saved prefs
  ThemeMode get mode {
    _getPrefs();
    return _mode;
  }

  // heamTeam data
  Map<String, dynamic> _homeTeamData = {};
  Map<String, dynamic> get homeTeamData => _homeTeamData;
  set homeTeamData(Map<String, dynamic> data) {
    _homeTeamData = data;
    notifyListeners();
  }

  // awayTeam data
  Map<String, dynamic> _awayTeamData = {};
  Map<String, dynamic> get awayTeamData => _awayTeamData;
  set awayTeamData(Map<String, dynamic> data) {
    _awayTeamData = data;
    notifyListeners();
  }

// match date
  Map<String, dynamic> _matchDateId = {};
  Map<String, dynamic> get matchDateId => _matchDateId;
  set matchDateId(Map<String, dynamic> id) {
    _matchDateId = id;
    notifyListeners();
  }
}
