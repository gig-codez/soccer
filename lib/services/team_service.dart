import 'dart:io';

import 'package:soccer/apis/Apis.dart';
import 'package:soccer/models/team.dart';

import '../exports/exports.dart';
import '../tools/tools.dart';

class TeamService {
  Future<List<Message>> getTeams() async {
    String res = "";
    try {
      Response response = await Client().get(Uri.parse(Apis.fetchTeams));
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
      Response response =
          await Client().post(Uri.parse(Apis.createTeam), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Team created successfully", color: Colors.green);
      } else {
        showMessage(msg: "Team creation failed", color: Colors.red);
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
