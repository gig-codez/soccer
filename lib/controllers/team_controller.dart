import '/models/team.dart';
import '/services/team_service.dart';

import '../exports/exports.dart';

class TeamController with ChangeNotifier {
// ----------selected team.
  Map<String, dynamic> _selectedTeam = {};
  Map<String, dynamic> get selectedTeam => _selectedTeam;
  set selectedTeam(Map<String, dynamic> team) {
    _selectedTeam = team;
    notifyListeners();
  }
// ----------------------------------

  List<Message> _teams = [];
  List<Message> get teams => _teams;
  // loading
  bool _loading = true;
  bool get loading => _loading;
  void getTeams(String leagueId) async {
    TeamService().getTeams(leagueId).then((event) {
      _teams = event;
      _loading = false;
      notifyListeners();
    });
  }

  // awayTeam
  List<Message> _awayTeams = [];
  List<Message> get awayTeams => _awayTeams;
  set awayTeams(List<Message> teams) {
    _awayTeams = teams;
    notifyListeners();
  }
}
