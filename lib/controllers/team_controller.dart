import 'package:soccer/models/team.dart';
import 'package:soccer/services/team_service.dart';

import '../exports/exports.dart';

class TeamController with ChangeNotifier {
  List<Message> _teams = [];
  List<Message> get teams => _teams;
// ----------selected team.
  Map<String, dynamic> _selectedTeam = {};
  Map<String, dynamic> get selectedTeam => _selectedTeam;
  set selectedTeam(Map<String, dynamic> team) {
    _selectedTeam = team;
    notifyListeners();
  }

// ----------------------------------
  Future<void> getTeams(String leagueId) async {
    TeamService().getTeams(leagueId).asStream().listen((event) {
      _teams = event;
      notifyListeners();
    });
  }
}
