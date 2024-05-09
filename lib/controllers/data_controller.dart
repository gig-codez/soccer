import '../exports/exports.dart';
import '../models/fixture.dart';
import '../models/match_date.dart';
import '../models/player.dart';
import '../services/fixture_service.dart';
import '../services/match_date_service.dart';
import '../services/player_service.dart';

class DataController with ChangeNotifier {
  // data loading
  bool _dataLoading = false;
  bool get dataLoading => _dataLoading;
  set dataLoading(bool state) {
    _dataLoading = state;
    notifyListeners();
  }

  void setLeagueId(String id) {
    fetchMatchDates(id);
    // fetchFixtureData(id);
  }

  List<MatchDateModel> _matchDates = [];
  List<MatchDateModel> get matchDates => _matchDates;

  // fixture data
  List<Datum> _fixtureData = [];
  List<Datum> get fixtureData => _fixtureData;
// players
  List<Message> _players = [];
  List<Message> get players => _players;
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

  void fetchPlayers(String teamId) {
    PlayerService().getPlayers(teamId).then((value) {
      _players = value;
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  // fixture updates
  bool _halfEnded = false;
  bool _matchEnded = false;
  bool get halfEnded => _halfEnded;
  bool get matchEnded => _matchEnded;
  void setFixtureUpdates(String league, String fixtureId) {
    FixtureService.getFixtures(league).then((value) {
      var fixture = value.where((element) => element.id == fixtureId).first;
// handling half time
      if ((fixture.halfEnded == true) && (fixture.matchEnded == false)) {
        _halfEnded = true;
        notifyListeners();
      }
      // handling match ended.
      if (fixture.matchEnded == true) {
        _matchEnded = false;
        notifyListeners();
      }
    });
  }

  Map<String, dynamic> _playerData = {};
  Map<String, dynamic> get playerData => _playerData;
  set playerData(Map<String, dynamic> data) {
    _playerData = data;
    notifyListeners();
  }

  // blogs
  List<BlogsModel> _blogs = [];
  List<BlogsModel> get blogs => _blogs;

  void fetchBlogs(String league) {
    BlogService.getBlogs(league).then((value) {
      _blogs = value;
      notifyListeners();
    });
  }
}
