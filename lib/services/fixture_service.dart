import '../apis/Apis.dart';
import '../exports/exports.dart';
import '../tools/tools.dart';

class FixtureService {
  static void getFixtures() async {
    String res = "";
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchFixtures),
      );
      if (response.statusCode == 200) {
        res = response.body;
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // function to add a fixture
  void createFixture(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.createFixture), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Fixture added successfully");
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
