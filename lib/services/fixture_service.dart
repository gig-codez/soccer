import 'dart:developer';

import '/controllers/loader_controller.dart';

import '../exports/exports.dart';
import '../models/fixture.dart';
import "dart:convert";

class FixtureService {
  static BuildContext context = navigatorKey.currentContext!;
  static Future<List<Datum>> getFixtures(String leagueId) async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchFixtures + leagueId),
      );
      if (response.statusCode == 200) {
        return fixtureModelFromJson(response.body).data;
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      return Future.error(e.message);
    }
  }

  static Future<List<Datum>> getRunningFixtures(
      String leagueId, String matchId) async {
    try {
      Response response = await Client().get(
        Uri.parse("${Apis.runningFixture}$leagueId/$matchId"),
      );
      if (response.statusCode == 200) {
        Client().close();
        return fixtureModelFromJson(response.body).data;
      } else {
        Client().close();
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      Client().close();
      return Future.error(e.message);
    }
  }

  // function to add a fixture
  void createFixture(Map<String, dynamic> data) async {
    try {
      // trigger loader
      showLoader(text: "Creating new fixture");
      Response response = await Client().post(
        Uri.parse(Apis.createFixture),
        body: data,
      );
      if (response.statusCode == 200) {
        // hide loader
        Routes.popPage();
        showMessage(msg: "Fixture added successfully");
        Routes.popPage();
        Client().close();
      } else {
        // hide loader
        Routes.popPage();
        showMessage(msg: "Fixture adding failed", color: Colors.red);
        Routes.popPage();
        Client().close();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      Client().close();
    }
  }

  static void deleteFixture(String fixtureId) async {
    try {
      Response res = await Client().delete(
        Uri.parse(Apis.deleteFixture + fixtureId),
      );
      if (res.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Fixture deleted successfully");
      } else {
        Routes.popPage();
        showMessage(msg: "Fixture not deleted successfully", color: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }

  static void updateFixture(String fixtureId, Map<String, dynamic> data) async {
    try {
      Response res = await Client().put(
        Uri.parse(Apis.updateFixture + fixtureId),
        body: data,
      );
      // print(res.body);
      if (res.statusCode == 200) {
        Client().close();
        showMessage(msg: "Fixture updated successfully");
        // ignore: use_build_context_synchronously
        Provider.of<LoaderController>(context, listen: false).isLoading = false;
        Routes.popPage();
      } else {
        Client().close();
        showMessage(msg: "Failed to  update fixture");
        // ignore: use_build_context_synchronously
        Provider.of<LoaderController>(context, listen: false).isLoading = false;
        Routes.popPage();
      }
    } on ClientException catch (e) {
      Client().close();
      // ignore: use_build_context_synchronously
      Provider.of<LoaderController>(context, listen: false).isLoading = false;
      debugPrint(e.message);
    }
  }

  static void runFixture(String fixtureId) async {
    try {
      Response res = await Client().put(
        Uri.parse(Apis.runFixture + fixtureId),
      );
      // print(res.body);
      if (res.statusCode == 200) {
        Client().close();
        showMessage(msg: "Started successfully");
      } else {
        Client().close();
        showMessage(msg: "Failed to  update fixture");
      }
    } on ClientException catch (e) {
      Client().close();
      return Future.error(e.message);
    }
  }

  static void endRunningFixture(String fixtureId) async {
    try {
      Response res = await Client().put(
        Uri.parse(Apis.endRunningFixture + fixtureId),
      );
      // print(res.body);
      if (res.statusCode == 200) {
        showMessage(msg: "Stopped successfully");
      } else {
        showMessage(msg: "Failed to  update fixture");
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  static void updateFixtureGoals(Map<String, dynamic> data) async {
    try {
      showLoader(text: "Updating fixture");
      Response res = await Client().put(
        Uri.parse(Apis.fixtureGoals + data["fixtureId"]),
        body: data,
      );
      // print(res.body);
      if (res.statusCode == 200) {
        Routes.popPage();
        Client().close();
        showMessage(msg: "Fixture updated successfully");
        Routes.popPage();
      } else {
        Routes.popPage();
        Client().close();
        showMessage(msg: json.decode(res.body)['message']);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      Routes.popPage();
      Client().close();
      debugPrint(e.message);
    }
  }
}
