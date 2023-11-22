import '/exports/exports.dart';
import '/models/result.dart';

class ResultService {
  static Future<List<Datum>> getResult() async {
    String res = "";
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchResults),
      );
      if (response.statusCode == 200) {
        res = response.body;
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
    return artworkModelFromJson(res).data;
  }

  static void updateResult(String leagueId, String teamId) async {
    try {
      Response response = await Client().put(
        Uri.parse(Apis.fetchResults),
      );
      if (response.statusCode == 200) {
        showMessage(msg: "Fixture updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Failed to update fixture.", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
