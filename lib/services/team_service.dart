import 'dart:convert';
import 'dart:io';

import '/models/team.dart';
import '/exports/exports.dart';
import 'dart:developer';

class TeamService {
  Future<List<Message>> getTeams(String leagueId) async {
    String res = "";
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchTeams + leagueId),
      );
      if (response.statusCode == 200) {
        Client().close();
        res = response.body;
        return teamModelFromJson(res).message;
      } else {
        Client().close();
        return Future.error(json.decode(response.body)['message']);
      }
    } on Exception catch (e) {
      Client().close();
      return Future.error(e.toString());
    }
  }

  static void createTeam(Map<String, dynamic> data) async {
    try {
      MultipartRequest request =
          MultipartRequest("POST", Uri.parse(Apis.createTeam));

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      request.fields['name'] = data['name'];
      request.fields['action'] = "team";
      request.fields['league'] = data['league'];
      request.files.add(
        MultipartFile(
          "file",
          data["stream"],
          data["length"],
          filename: data["filename"],
        ),
      );
      // print(data);

      var res = await request.send();

      if (res.statusCode == 200) {
        Client().close();
        showMessage(msg: "Team created successfully");
        Routes.popPage();
      } else {
        Client().close();
        Routes.popPage();
        showMessage(msg: "Team creating failed", color: Colors.red);
      }
    } on ClientException catch (e) {
      Client().close();
      debugPrint(e.message);
    } on SocketException catch (e) {
      Client().close();
      debugPrint(e.message);
    } on HttpException catch (e) {
      Client().close();
      debugPrint(e.message);
    } catch (e) {
      Client().close();
      throw Exception(e.toString());
    }
  }

  static void updateTeam(Map<String, dynamic> data, String id) async {
    try {
      MultipartRequest request =
          MultipartRequest("PUT", Uri.parse(Apis.updateTeam + id));

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
      });
      request.fields['name'] = data['name'];
      request.fields['league'] = data['league'];
      request.fields['action'] = "team";
      if (data['stream'] != null) {
        request.files.add(
          MultipartFile(
            "file",
            data["stream"],
            data["length"],
            filename: data["filename"],
          ),
        );
      }
      var res = await request.send();

      if (res.statusCode == 200) {
        Client().close();
        showMessage(msg: "Team updated successfully");
        Routes.popPage();
      } else {
        Client().close();
        Routes.popPage();
        showMessage(
            msg: "Team update failed ${res.reasonPhrase}", color: Colors.red);
      }
    } on ClientException catch (e) {
      Client().close();
      debugPrint(e.message);
    } on SocketException catch (e) {
      Client().close();
      debugPrint(e.message);
    } on HttpException catch (e) {
      Client().close();
      debugPrint(e.message);
    } catch (e) {
      Client().close();
      log(e.toString());
    }
  }

  static void deleteTeam(String id) async {
    showLoader(text: "Deleting...");
    try {
      Response res = await Client().delete(Uri.parse(Apis.deleteTeam + id));
      if (res.statusCode == 200) {
        Client().close();
        Routes.popPage();
        Routes.popPage();
        showMessage(msg: "Team deleted successfully", color: Colors.green);
      } else {
        Client().close();
        Routes.popPage();
        showMessage(msg: "Team deleting failed", color: Colors.red);
      }
    } on ClientException catch (e) {
      Client().close();
      Routes.popPage();
      // showMessage(msg: e.message, color: Colors.red);
    }
  }
}
