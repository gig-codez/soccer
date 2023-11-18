import '../exports/exports.dart';
import '../models/fixture.dart';

class FixtureService {
  static Future<List<Datum>> getFixtures(String leagueId) async {
    String res = "";
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchFixtures + leagueId),
      );
      if (response.statusCode == 200) {
        res = response.body;
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
    return fixtureModelFromJson(res).data;
  }

  // function to add a fixture
  void createFixture(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.createFixture), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Fixture added successfully");
        Routes.popPage();
      } else {
        showMessage(msg: "Fixture adding failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
