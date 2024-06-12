import '../exports/exports.dart';
import '../models/table_model.dart';

class TableService {
  Future<List<Message>> getTeams(String leagueId) async {
    String res = "";
    try {
      Response response =
          await Client().get(Uri.parse(Apis.getTableData + leagueId));
      if (response.statusCode == 200) {
        res = response.body;
      } else {
        showMessage(msg: "Something went wrong");
      }
    } on ClientException catch (e) {
      showMessage(msg: e.message);
    }
    return tableModelFromJson(res).message;
  }

  Future<void> addTableData(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.addTableData), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Table Data added successfully");
      } else {
        showMessage(msg: "Something went wrong");
      }
    } catch (e) {
      print(e);
    }
  }

  // service function to delete data from table
  Future<void> deleteTableData(String id) async {
    try {
      Response response = await Client().delete(
        Uri.parse(Apis.deleteTableData + id),
      );
      if (response.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Table Data deleted successfully");
      } else {
        Routes.popPage();
        showMessage(msg: "Something went wrong, Couldn't delete data");
      }
    } on ClientException catch (e) {
      showMessage(msg: e.message);
    }
  }

  Future<void> updateTableData(String id, Map<String, dynamic> data) async {
    try {
      Response response = await Client().put(
        Uri.parse(Apis.updateTableData + id),
        body: data,
      );
      // debugPrint(response.reasonPhrase! + response.body);
      if (response.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Table Data updated successfully");
      } else {
        Routes.popPage();
        showMessage(msg: "Something went wrong, Couldn't update data");
      }
    } on ClientException {
      // showMessage(msg: e.message);
    }
  }

  // function to reset table data
  Future<void> resetTableData(String leagueId) async {
    try {
      Response response = await Client().put(
        Uri.parse(Apis.resetTableData + leagueId),
      );
      showAdaptive(
        const SizedBox.square(
          dimension: 100,
          child: Row(
            children: [
              Text("Reset table data"),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
      if (response.statusCode == 200) {
        print(response.body);
        Routes.popPage();
        showMessage(msg: "Table Data reset successfully");
      } else {
        showMessage(msg: "Something went wrong");
      }
    } on ClientException catch (e) {
      showMessage(msg: e.message);
    }
  }
}
