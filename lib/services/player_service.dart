import 'dart:io';

import '../exports/exports.dart';
import '../models/player.dart';

class PlayerService {
//  get all players
  Future<List<Message>> getPlayers(String teamId) async {
    String res = "";
    try {
      final response = await Client().get(
        Uri.parse(Apis.fetchPlayers + teamId),
      );
      if (response.statusCode == 200) {
        res = response.body;
        // debugPrint(res);
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
    return playersModelFromJson(res).message;
  }

// delete player
  static void deletePlayer(String playerId) async {
    try {
      Response response =
          await Client().delete(Uri.parse(Apis.deletePlayer + playerId));
      if (response.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Player deleted successfully", color: Colors.green);
      } else {
        Routes.popPage();
        showMessage(
            msg: "Error deleting player => ${response.reasonPhrase}",
            color: Colors.red);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // function to create a player
  static void createPlayer(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.createPlayer), body: data);

      if (response.statusCode == 200) {
        showMessage(msg: "Done..");
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // edit players
  static updatePlayer(String id, Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().put(Uri.parse(Apis.updatePlayer + id), body: data);

      if (response.statusCode == 200) {
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  static attachGoalToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      Response response = await Client()
          .put(Uri.parse("${Apis.goalRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // assist
  static attachAssistToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      Response response = await Client()
          .put(Uri.parse("${Apis.assistRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // yellow card
  static attachYellowCardToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      Response response = await Client()
          .put(Uri.parse("${Apis.yellowCardRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        debugPrint(response.body);
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // red card
  static attachRedCardToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      Response response = await Client()
          .put(Uri.parse("${Apis.redCardRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        debugPrint(response.body);
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  static void castMessage(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.castMessage), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Message sent successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Message sending failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
