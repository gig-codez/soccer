import 'package:soccer/services/fixture_service.dart';
import 'package:soccer/services/results_service.dart';
import 'package:soccer/widgets/custom_divider.dart';

import '/models/fixture.dart';
import '/widgets/PlayingTeams.dart';
import '/exports/exports.dart';

class FixtureResults extends StatefulWidget {
  final String fixtureId;
  final String leagueId;
  final Datum data;
  const FixtureResults({
    super.key,
    required this.fixtureId,
    required this.leagueId,
    required this.data,
  });

  @override
  State<FixtureResults> createState() => _FixtureResultsState();
}

class _FixtureResultsState extends State<FixtureResults> {
  final _homeScoreController = TextEditingController();
  final _awayScoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixture Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 0.0),
        child: Column(
          children: [
            PlayingTeams(data: widget.data),
            const SizedBox.square(
              dimension: 20,
            ),
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
                    "awayGoals": _awayScoreController.text
                  });
                }
              },
            ),
            SizedBox.square(
              dimension: MediaQuery.of(context).size.width / 1.5,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: 200,
                    onPress: () {
                      FixtureService.updateFixture({
                        "fixtureId": widget.fixtureId,
                        "isLive": "true",
                      });
                    },
                    text: "Start fixture",
                  ),
                ),
                const SizedBox.square(
                  dimension: 20,
                ),
                // Expanded(
                //   child: CustomButton(
                //     width: 200,
                //     buttonColor: Theme.of(context).primaryColor,
                //     textColor: Colors.white,
                //     onPress: () {},
                //     text: "Stop Fixture",
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
