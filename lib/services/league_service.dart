import '../apis/Apis.dart';
import '../exports/exports.dart';
import '../models/league.dart';
import '../tools/tools.dart';

class LeagueService {
  Future<List<Message>> getLeague() async {
    String res = "";
    try {
      Response response = await Client().get(Uri.parse(Apis.fetchLeagues));
      if (response.statusCode == 200) {
        res = response.body;
      } else {
        showMessage(msg: "Something went wrong", color: Colors.red);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
    return leaguesModelFromJson(res).message;
  }

  // function to create a league
  void createLeague(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.createLeague), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "League added successfully");
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
