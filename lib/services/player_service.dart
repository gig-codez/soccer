import 'dart:io';

import 'package:soccer/apis/Apis.dart';
import 'package:soccer/tools/tools.dart';

import '../exports/exports.dart';
import '../models/player.dart';

class PlayerService {
//  get all players
  Future<List<Message>> getPlayers() async {
    String res = "";
    try {
      final response = await Client().get(
        Uri.parse(Apis.fetchPlayers),
      );
      if (response.statusCode == 200) {
        res = response.body;
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

  // function to create a player
  static void createPlayer(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.createPlayer), body: data);
      if (response.statusCode == 200) {
        showMessage(msg: "Player added successfully", color: Colors.green);
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
      } else {
        showMessage(msg: "Player update failed", color: Colors.red);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
