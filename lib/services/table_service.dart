import '../exports/exports.dart';
import '../models/table_model.dart';

class TableService {
  Future<List<Message>> getTeams(String leagueId) async {
    String res = "";
    try {
      Response response =
          await Client().get(Uri.parse(Apis.getTableData + leagueId));
      if (response.statusCode == 200) {
        Client().close();
        res = response.body;
        return tableModelFromJson(res).message;
      } else {
        Client().close();
        return Future.error("Something went wrong");
      }
    } on ClientException catch (e) {
      Client().close();
      return Future.error(e.message);
    }
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
        Client().close();
        Routes.popPage();
        showMessage(msg: "Table Data deleted successfully");
      } else {
        Client().close();
        Routes.popPage();
        showMessage(msg: "Something went wrong, Couldn't delete data");
      }
    } on ClientException catch (e) {
      Client().close();
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
        Client().close();
        Routes.popPage();
        showMessage(msg: "Table Data updated successfully");
      } else {
        Client().close();
        Routes.popPage();
        showMessage(msg: "Something went wrong, Couldn't update data");
      }
    } on ClientException {
      Client().close();
      // showMessage(msg: e.message);
    }
  }

  // function to reset table data
  Future<void> resetTableData(String leagueId) async {
    try {
      showLoader(text: "Resetting Table Data");
      Response response = await Client().put(
        Uri.parse(Apis.resetTableData + leagueId),
      );

      if (response.statusCode == 200) {
        Routes.popPage();
        Client().close();
        print(response.body);
        Routes.popPage();
        showMessage(msg: "Table Data reset successfully");
      } else {
        Routes.popPage();
        Client().close();
        showMessage(msg: "Something went wrong");
      }
    } on ClientException catch (e) {
      Client().close();
      showMessage(msg: e.message);
    }
  }
}
