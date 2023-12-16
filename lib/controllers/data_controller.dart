import '../exports/exports.dart';
import '../models/fixture.dart';
import '../models/match_date.dart';
import '../services/fixture_service.dart';
import '../services/match_date_service.dart';

class DataController with ChangeNotifier {
  // leagueId
  // String _leagueId = "";

  void setLeagueId(String id) {
    fetchMatchDates(id);
    // fetchFixtureData(id);
  }

  List<MatchDateModel> _matchDates = [];
  List<MatchDateModel> get matchDates => _matchDates;

  // fixture data
  List<Datum> _fixtureData = [];
  List<Datum> get fixtureData => _fixtureData;

  void fetchMatchDates(String leagueId) {
    MatchDateService.getMatchDates(leagueId).then((value) {
      _matchDates = value;
      notifyListeners();
    });
  }

 void fetchFixtureData(String leagueId, String matchId) {
    FixtureService.getRunningFixtures(leagueId, matchId).then((value) {
      _fixtureData = value;
      notifyListeners();
    });
  }
}
