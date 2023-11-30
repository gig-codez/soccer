import '/services/fixture_service.dart';

import '/models/fixture.dart';
import '/widgets/PlayingTeams.dart';
import '/exports/exports.dart';
import 'fixture/away_team.dart';
import 'fixture/home_team.dart';
import 'show_match_dates.dart';
import 'widgets/update_fixture_results.dart';

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
                                      return const ShowMatchDates();
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
        child: Column(
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
                  HomeTeamFixture(id: widget.data.hometeam.id),
                  AwayTeamFixture(id: widget.data.awayteam.id),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomButton(
                width: 200,
                onPress: () {
                  FixtureService.updateFixture(widget.fixtureId, {
                    "isLive": "true",
                  });
                },
                text: "Start fixture",
              ),
            ),
            const SizedBox.square(
              dimension: 40,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (BuildContext context) {
              return BottomSheet(
                onClosing: () {},
                builder: (context) {
                  return UpdateFixtureResults(
                    fixtureId: widget.fixtureId,
                  );
                },
              );
            },
          );
        },
        // label: const Text("Edit Results"),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
