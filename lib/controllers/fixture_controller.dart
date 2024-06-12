import 'package:samba_stats/models/fixture.dart';

import '../services/fixture_service.dart';
import '/exports/exports.dart';

class FixtureController with ChangeNotifier {
  Datum _fixtureData = new Datum.fromJson({});
  Datum get fixtureData => _fixtureData;

  void fetchFixtureData(String leagueId, String fixtureId) {
    FixtureService.getFixtures(leagueId).then((value) {
      _fixtureData = value.where((element) => element.id == fixtureId).first;
      notifyListeners();
    });
  }
}
