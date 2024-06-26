// import '../../../../controllers/loader_controller.dart';
import '/services/fixture_service.dart';
import '/widgets/custom_divider.dart';
import '/exports/exports.dart';

class UpdateFixtureResults extends StatefulWidget {
  final String fixtureId;
  final String hometeam;
  final String awayteam;
  final String leagueId;
  const UpdateFixtureResults(
      {super.key,
      required this.fixtureId,
      required this.hometeam,
      required this.awayteam,
      required this.leagueId});

  @override
  State<UpdateFixtureResults> createState() => _UpdateFixtureResultsState();
}

class _UpdateFixtureResultsState extends State<UpdateFixtureResults> {
  final _homeScoreController = TextEditingController();
  final _awayScoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 1.2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              child: CustomDivider(text: "Update fixture"),
            ),
            CommonTextField(
              titleText: "Home Score",
              hintText: "Home Score",
              controller: _homeScoreController,
              enableBorder: true,
              keyboardType: TextInputType.number,
            ),
            CommonTextField(
              titleText: "Away Score",
              controller: _awayScoreController,
              enableBorder: true,
              hintText: "Away Score",
              keyboardType: TextInputType.number,
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            CustomButton(
              text: "Update Fixture",
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPress: () {
                if (_homeScoreController.text.isEmpty ||
                    _awayScoreController.text.isEmpty) {
                  showMessage(
                    msg: "Please fill all the fields",
                    color: Colors.red,
                  );
                } else {
                  FixtureService.updateFixtureGoals({
                    "fixtureId": widget.fixtureId,
                    "homeGoals": _homeScoreController.text,
                    "awayGoals": _awayScoreController.text,
                    "hometeam": widget.hometeam,
                    "awayteam": widget.awayteam,
                    "league": widget.leagueId,
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
