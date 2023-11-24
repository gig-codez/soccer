import 'dart:io';

import '/models/team.dart';
import '../exports/exports.dart';

class TeamService {
  Future<List<Message>> getTeams(String leagueId) async {
    String res = "";
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchTeams + leagueId),
      );
      if (response.statusCode == 200) {
        res = response.body;
      }
    } on ClientException catch (_) {
      debugPrint(_.message);
    } on SocketException catch (_) {
      debugPrint(_.message);
    } on HttpException catch (_) {
      debugPrint(_.message);
    } catch (e) {
      throw Exception(e.toString());
    }
    return teamModelFromJson(res).message;
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
      print(res.reasonPhrase);
      if (res.statusCode == 200) {
        showMessage(msg: "Team created successfully");
        Routes.popPage();
      } else {
        Routes.popPage();
        showMessage(msg: "Team creating failed", color: Colors.red);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    } on SocketException catch (e) {
      debugPrint(e.message);
    } on HttpException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static void updateTeam(Map<String, dynamic> data, String id) async {
    try {
      Response response =
          await Client().put(Uri.parse(Apis.updateTeam + id), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Team updated successfully", color: Colors.green);
      } else {
        showMessage(msg: "Team update failed", color: Colors.red);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    } on SocketException catch (e) {
      debugPrint(e.message);
    } on HttpException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
