import '/exports/exports.dart';
import '/models/league.dart';

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
      // Response response =
      //     await Client().post(Uri.parse(Apis.createLeague), body: data);
      MultipartRequest request =
          MultipartRequest("POST", Uri.parse(Apis.createLeague));

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      request.fields['name'] = data['name'];
      request.files.add(
        MultipartFile(
          "file",
          data["stream"],
          data["length"],
          filename: data["filename"],
        ),
      );
      var response = await request.send();
      if (response.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "League added successfully");
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
