import '../teams/AwayTeamsWidget.dart';
import '../leagues/show_leagues.dart';

import '/services/fixture_service.dart';

import '/exports/exports.dart';
import '/views/pages/sections/match_dates/show_match_dates.dart';

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
  var kickOffTimeController = TextEditingController();

  bool twoHavles = false;
  bool fourHavles = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Consumer<AppController>(builder: (context, controller, child) {
            // setState(() {
            homeTeamController.text = controller.homeTeamData['name'] ?? "";

            awayTeamController.text = controller.awayTeamData['name'] ?? "";

            kickOffController.text = controller.matchDateId["date"] ?? "";
            // });
            return Column(
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
                  enableSuffix: true,
                  suffixIcon: Icons.add,
                  icon: Icons.home_filled,
                  readOnly: true,
                  onTapSuffix: () {
                    showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return ShowLeagues(
                                  leagueId: widget.leagueId,
                                );
                              });
                        });
                  },
                  onChanged: (v) {},
                  enableBorder: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  controller: homeTeamController,
                ),
                CommonTextField(
                  titleText: "Away Team",
                  readOnly: true,
                  icon: Icons.home_mini_rounded,
                  hintText: "Enter away team",
                  enableSuffix: true,
                  suffixIcon: Icons.add,
                  onTapSuffix: () {
                    showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return AwayTeamsWidget(
                                  leagueId: widget.leagueId,
                                );
                              });
                        });
                  },
                  enableBorder: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  controller: awayTeamController,
                ),
                CommonTextField(
                  titleText: "Minutes to be Played",
                  icon: Icons.timelapse,
                  keyboardType: TextInputType.number,
                  hintText: "e.g 20 mins",
                  enableBorder: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  controller: minutesPlayedController,
                ),
                CommonTextField(
                  titleText: "Time of kick off",
                  icon: Icons.timelapse,
                  readOnly: true,
                  hintText: "e.g 20 mins",
                  enableBorder: true,
                  enableSuffix: true,
                  suffixIcon: Icons.add_alarm_outlined,
                  onTapSuffix: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((time) {
                      setState(() {
                        kickOffTimeController.text =
                            time!.format(context).toString();
                      });
                    });
                  },
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  controller: kickOffTimeController,
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
                CommonTextField(
                  controller: kickOffController,
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                  titleText: "Kick Off Date",
                  hintText: "Enter league name",
                  contentPadding: const EdgeInsets.all(10),
                  enableBorder: true,
                  enableSuffix: true,
                  suffixIcon: Icons.calendar_month_rounded,
                  onTapSuffix: () {
                    showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (BuildContext context) {
                        return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return ShowMatchDates(
                              leagueId: widget.leagueId,
                            );
                          },
                        );
                      },
                    );
                  },
                  onChanged: (n) async {},
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
                      debugPrint("Saved ${controller.matchDateId}");
                      FixtureService().createFixture(
                        {
                          "hometeam": controller.homeTeamData['id'],
                          "awayteam": controller.awayTeamData['id'],
                          "minutesplayed": minutesPlayedController.text,
                          "kickofftime":
                              kickOffTimeController.text.split(" ").first,
                          "twohalves": "$twoHavles",
                          "fourhavles": "$fourHavles",
                          "league": widget.leagueId,
                          "fixtureDate": controller.matchDateId["id"],
                          "isLive": "false",
                          "homeGoals": "0",
                          "awayGoals": "0"
                        },
                      );

                      controller.homeTeamData = {};
                      controller.awayTeamData = {};
                      controller.matchDateId = {};
                    }
                  },
                  text: "Save Fixture data",
                ),
                const SizedBox.square(
                  dimension: 90,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
