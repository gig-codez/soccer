import '../../../services/fixture_service.dart';
import '/services/fixture_service.dart';

import '/exports/exports.dart';

class AddFixture extends StatefulWidget {
  final String leagueId;
  const AddFixture({
    super.key,
    required this.leagueId,
  });

  @override
  State<AddFixture> createState() => _AddFixtureState();
}

class _AddFixtureState extends State<AddFixture> {
  final homeTeamController = TextEditingController();
  final awayTeamController = TextEditingController();
  final minutesPlayedController = TextEditingController();
  final kickOffController = TextEditingController();
  bool twoHavles = false;
  bool fourHavles = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 13),
                child: Text(
                  "Add Fixture Information",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              CommonTextField(
                titleText: "Home Team",
                hintText: "Enter home team",
                icon: Icons.home_filled,
                onChanged: (x) {},
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: homeTeamController,
              ),
              CommonTextField(
                titleText: "Away Team",
                icon: Icons.home_mini_rounded,
                hintText: "Enter away team",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: awayTeamController,
              ),
              CommonTextField(
                titleText: "Minutes to be Played",
                icon: Icons.timelapse,
                hintText: "e.g 20 mins",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: minutesPlayedController,
              ),
              CommonTextField(
                titleText: "Time of kick off",
                icon: Icons.timelapse,
                hintText: "e.g 20 mins",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: kickOffController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Times Of Fixture",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile.adaptive(
                      value: twoHavles,
                      groupValue: true,
                      onChanged: (x) {
                        setState(() {
                          fourHavles = false;
                          twoHavles = true;
                        });
                      },
                      title: const Text("2 Halfs"),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile.adaptive(
                      value: fourHavles,
                      groupValue: true,
                      onChanged: (x) {
                        setState(() {
                          fourHavles = true;
                          twoHavles = false;
                        });
                      },
                      title: const Text("4 Quarters"),
                    ),
                  )
                ],
              ),
              CustomButton(
                onPress: () {
                  if (homeTeamController.text.isEmpty ||
                      awayTeamController.text.isEmpty ||
                      minutesPlayedController.text.isEmpty ||
                      kickOffController.text.isEmpty) {
                    showMessage(
                        msg: "Please fill all the fields", color: Colors.red);
                  } else {
                    FixtureService().createFixture(
                      {
                        "hometeam": homeTeamController.text,
                        "awayteam": awayTeamController.text,
                        "minutesplayed": minutesPlayedController.text,
                        "kickofftime": kickOffController.text,
                        "twohalves": twoHavles,
                        "fourhavles": fourHavles,
                        "league": widget.leagueId,
                        "date": ""
                      },
                    );
                  }
                },
                text: "Save Fixture data",
              ),
              const SizedBox.square(
                dimension: 90,
              )
            ],
          ),
        ),
      ),
    );
  }
}
