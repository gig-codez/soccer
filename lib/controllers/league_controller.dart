import '../services/league_service.dart';
import '/exports/exports.dart';
import '/models/league.dart';

class LeagueController with ChangeNotifier {
  List<Message> _leagues = [];
  bool _loading = true;
  bool get loading => _loading;
  List<Message> get leagues {
    return _leagues;
  }

  void fetchLeagues() {
    LeagueService().getLeague().then((value) {
      _leagues = value;
      _loading = false;
      notifyListeners();
    });
  }
}
