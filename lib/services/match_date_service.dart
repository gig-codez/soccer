import '../exports/exports.dart';
import '../models/match_date.dart';

class MatchDateService {
  static void deleteMatchDate(String id) async {
    try {
      Response res =
          await Client().delete(Uri.parse(Apis.deleteMatchDates + id));
      if (res.statusCode == 200) {
        showMessage(msg: "Match date removed successfully.");
        Routes.popPage();
      } else {
        showMessage(msg: "Match date removing failed.");
        Routes.popPage();
      }
    } on ClientException catch (e) {
      print(e.message);
    }
  }

  static Future<List<MatchDateModel>> getMatchDates(String leagueId) async {
    String r = "";
    try {
      Response res =
          await Client().get(Uri.parse(Apis.getMatchDates + leagueId));
      if (res.statusCode == 200) {
        r = res.body;
      }
    } catch (e) {
      // print(e);
    }
    return matchDateModelFromJson(r);
  }

  static void savedMatchDate(Map<String, dynamic> data) async {
    try {
      Response res =
          await Client().post(Uri.parse(Apis.addMatchDates), body: data);
      if (res.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Match Date added successfully");
      } else {
        Routes.popPage();
        showMessage(msg: "Match Date adding failed");
      }
    } on ClientException catch (e) {
      // print(e);
    }
  }
}
