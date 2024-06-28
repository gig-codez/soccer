import '/services/player_service.dart';
import '/services/fixture_service.dart';

import '/models/fixture.dart';
import '/widgets/PlayingTeams.dart';
import '/exports/exports.dart';
import 'away_team.dart';
import 'home_team.dart';
import '../match_dates/show_match_dates.dart';
import '../widgets/castMessageWidget.dart';
import 'update_fixture_results.dart';

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

class _FixtureResultsState extends State<FixtureResults>
    with SingleTickerProviderStateMixin {
  final fixtureDateController = TextEditingController();
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    Provider.of<DataController>(context, listen: false)
        .setFixtureUpdates(widget.data.league, widget.data.id);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixture Results'),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                showModalSheet(CastMessage(leagueId: widget.leagueId));
              }),
          IconButton(
            icon: const Icon(Icons.edit_calendar_outlined),
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return Consumer<AppController>(
                      builder: (context, controller, x) {
                    fixtureDateController.text =
                        controller.matchDateId['date'] ?? "";
                    return Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      height: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const SizedBox.square(
                            dimension: 20,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
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
                            child: CommonTextField(
                              titleText: "Kick Off Date",
                              hintText: "xx-xx-xxxx",
                              icon: Icons.home_filled,
                              readOnly: true,
                              onChanged: (v) {},
                              enableBorder: true,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              controller: fixtureDateController,
                            ),
                          ),
                          const SizedBox.square(
                            dimension: 20,
                          ),
                          CustomButton(
                            text: "Update Fixture Date",
                            buttonColor: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPress: () {
                              if (fixtureDateController.text.isEmpty) {
                                showMessage(
                                  msg: "Kick off date can't be empty",
                                  color: Colors.red,
                                );
                              } else {
                                FixtureService.updateFixture(widget.fixtureId, {
                                  "fixtureDate": controller.matchDateId["id"],
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  });
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 0.0),
        child: Consumer<DataController>(builder: (context, controller, child) {
          if (mounted) {
            // invoke function
            // controller.setFixtureUpdates(widget.data.league, widget.data.id);
          }
          return Column(
            children: [
              Expanded(child: PlayingTeams(data: widget.data)),
              TabBar(
                controller: tabController,
                tabs: [
                  Tab(text: "${widget.data.hometeam.name}'s players"),
                  Tab(text: "${widget.data.awayteam.name}'s players"),
                ],
              ),
              Expanded(
                flex: 5,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    HomeTeamFixture(
                      id: widget.data.hometeam.id,
                      leagueId: widget.leagueId,
                    ),
                    AwayTeamFixture(
                      id: widget.data.awayteam.id,
                      leagueId: widget.leagueId,
                    ),
                  ],
                ),
              ),
              if (widget.data.matchEnded == false) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 2),
                  child: CustomButton(
                    buttonColor: Colors.green,
                    textColor: Colors.white,
                    width: 200,
                    onPress: () {
                      FixtureService.runFixture(widget.fixtureId);
                      if (widget.data.twohalves == true) {
                        PlayerService.castMessage({
                          "title": widget.data.twohalves
                              ? widget.data.halfEnded
                                  ? "Second Half started!"
                                  : "Match Day!"
                              : "Match Day!",
                          "league": widget.leagueId,
                          "body":
                              "Match for ${widget.data.hometeam.name} Vs ${widget.data.awayteam.name} has started",
                        });
                      } else {
                        PlayerService.castMessage({
                          "title": "Time Check",
                          "league": widget.leagueId,
                          "body":
                              "Match for ${widget.data.hometeam.name} Vs ${widget.data.awayteam.name} has started",
                        });
                      }
                    },
                    text: widget.data.twohalves
                        ? (widget.data.halfEnded == true &&
                                widget.data.matchEnded == false)
                            ? "Run Second Half"
                            : (widget.data.halfEnded == false &&
                                    widget.data.matchEnded == false)
                                ? "Run First Half"
                                : ""
                        : widget.data.quarterEnded
                            ? "Run second Quarter"
                            : widget.data.halfEnded
                                ? "Run third quarter"
                                : widget.data.secondHalfEnded
                                    ? "Run match"
                                    : "Run first quarter",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 2),
                  child: CustomButton(
                    width: 200,
                    onPress: () {
                      FixtureService.endRunningFixture(widget.fixtureId);
                    },
                    text: widget.data.twohalves
                        ? widget.data.halfEnded
                            ? "Stop Second Half"
                            : "Stop First Half"
                        : widget.data.quarterEnded
                            ? "Stop second Quarter"
                            : widget.data.halfEnded
                                ? "Stop third quarter"
                                : widget.data.secondHalfEnded
                                    ? "Stop match"
                                    : "Stop first quarter",
                  ),
                ),
                const SizedBox.square(
                  dimension: 40,
                )
              ],
            ],
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptive(
            UpdateFixtureResults(
              fixtureId: widget.fixtureId,
              hometeam: widget.data.hometeam.id,
              awayteam: widget.data.awayteam.id,
              leagueId: widget.data.league,
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
