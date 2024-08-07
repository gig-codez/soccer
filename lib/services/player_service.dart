// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import '../exports/exports.dart';
import '../models/handball_player_model.dart';
import '../models/player.dart';

class PlayerService {
//  get all players
  Future<List<Message>> getPlayers(String teamId) async {
    try {
      final response = await Client().get(
        Uri.parse(Apis.fetchPlayers + teamId),
      );
      if (response.statusCode == 200) {
        Client().close();
        return playersModelFromJson(response.body).message;
      } else {
        Client().close();
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on Exception catch (e) {
      Client().close();
      return Future.error(e.toString());
    }
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
      context.read<LoaderController>().isLoading = true;
      Response response = await Client()
          .put(Uri.parse("${Apis.goalRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        context.read<LoaderController>().isLoading = false;
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        context.read<LoaderController>().isLoading = false;
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      context.read<LoaderController>().isLoading = false;
      debugPrint(e.message);
    }
  }

  // assist
  static void attachAssistToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      context.read<LoaderController>().isLoading = true;

      Response response = await Client()
          .put(Uri.parse("${Apis.assistRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        context.read<LoaderController>().isLoading = false;

        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        context.read<LoaderController>().isLoading = false;

        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      context.read<LoaderController>().isLoading = false;
      debugPrint(e.message);
    }
  }

  // assist
  static attachCleanSheetToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      Response response = await Client().put(
          Uri.parse("${Apis.cleanSheetRoute}/${id}/sheet/$leagueId"),
          body: data);
      if (response.statusCode == 200) {
        showMessage(
            msg: "clean sheet recorded successfully", color: Colors.green);
        Routes.popPage();
      } else {
        print(response.body);
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
      context.read<LoaderController>().isLoading = true;

      Response response = await Client()
          .put(Uri.parse("${Apis.yellowCardRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        context.read<LoaderController>().isLoading = false;

        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        context.read<LoaderController>().isLoading = false;
        debugPrint(response.body);
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      context.read<LoaderController>().isLoading = false;
    }
  }

  // red card
  static attachRedCardToPlayer(
      String id, String leagueId, Map<String, dynamic> data) async {
    try {
      context.read<LoaderController>().isLoading = true;
      Response response = await Client()
          .put(Uri.parse("${Apis.redCardRoute}$id/$leagueId"), body: data);
      if (response.statusCode == 200) {
        context.read<LoaderController>().isLoading = false;
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        context.read<LoaderController>().isLoading = false;
        debugPrint(response.body);
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      context.read<LoaderController>().isLoading = false;
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

  static void transferPlayer(Map<String, dynamic> data) async {
    try {
      showLoader(text: "Recording transfer...");
      Response response = await Client().put(
        Uri.parse(
            "${Apis.transferPlayer + data['id']}/transferPlayer/${data['league']}"),
        body: {
          "team": data["team"],
          "sold_out": data["sold_out"],
        },
      );
      if (response.statusCode == 200) {
        Routes.popPage();
        showMessage(
            msg: "Player transferred successfully", color: Colors.green);
        Routes.popPage();
      } else {
        debugPrint(response.body);
        showMessage(msg: "Player transfer failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // get hand ball player data
  static Future<HandBallPlayerModel> getHandBallPlayers(
      {required String playerId, required String leagueId}) async {
    try {
      final response = await Client().get(
        Uri.parse("${Apis.fetchHandBallPlayer}$playerId/$leagueId"),
      );
      if (response.statusCode == 200) {
        Client().close();
        return handBallPlayerModelFromJson(response.body);
      } else {
        Client().close();
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on Exception catch (e) {
      Client().close();
      return Future.error(e.toString());
    }
  }

  // update player data
  static Future<bool> updateHandBallPlayer(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.addHandBallStats), body: data);

      if (response.statusCode == 200) {
        showMessage(msg: "Done..");
        return Future.value(true);
      } else {
        return Future.error(false);
      }
    } on ClientException catch (e) {
      return Future.error(false);
    }
  }

  static Future<List<Message>> getTransferredPlayers(String leagueId) async {
    try {
      final response = await Client().get(
        Uri.parse("${Apis.transferredPlayers}$leagueId/transferred"),
      );
      if (response.statusCode == 200) {
        // log(response.body);
        return playersModelFromJson(response.body).message;
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on ClientException catch (e) {
      return Future.error(e.message);
    } on SocketException catch (e) {
      return Future.error(e.message);
    } on HttpException catch (e) {
      return Future.error(e.message);
    }
  }

// delete transfer
  static Future deleteTransfer(String id) async {
    try {
      showLoader(text: "Deleting transfer.....");
      Response response = await Client().delete(
        Uri.parse(Apis.deleteTransfer + id),
      );
      if (response.statusCode == 200) {
        Routes.popPage();
        return Future.value(json.decode(response.body)['message']);
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
