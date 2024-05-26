import '/models/match_date.dart';
import '/exports/exports.dart';
import '/services/match_date_service.dart';

class MatchDateController with ChangeNotifier {
  List<MatchDateModel> _matchDates = [];
  List<MatchDateModel> get matchDates => _matchDates;
  bool _loading = true;
  bool get loading => _loading;
  void getMatchDates(String leagueId) {
    try {
      MatchDateService.getMatchDates(leagueId).then((dates) {
        _matchDates = dates;
        _loading = false;
        notifyListeners();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
