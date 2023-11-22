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

  static void deleteFixture(String fixtureId) async {
    try {
      Response res = await Client().delete(
        Uri.parse(Apis.deleteFixture + fixtureId),
      );
      if (res.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Fixture deleted successfully");
      } else {
        Routes.popPage();
        showMessage(msg: "Fixture not deleted successfully", color: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }

  static void updateFixture(Map<String, dynamic> data) async {
    try {
      Response res = await Client().put(
        Uri.parse(Apis.updateFixture + data["fixtureId"]),
        body: {
          "isLive": data["isLive"],
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        showMessage(msg: "Fixture updated successfully");
        Routes.popPage();
      } else {
        showMessage(msg: "Failed to  update fixture");
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
  static void updateFixtureGoals(Map<String, dynamic> data) async {
    try {
      Response res = await Client().put(
        Uri.parse(Apis.updateFixture + data["fixtureId"]),
        body: {
          "homeGoals": data["homeGoals"],
          "awayGoals": data["awayGoals"],
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        showMessage(msg: "Fixture updated successfully");
        Routes.popPage();
      } else {
        showMessage(msg: "Failed to  update fixture");
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
