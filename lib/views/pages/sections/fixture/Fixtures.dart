import 'dart:async';
import '/widgets/FixtureWidget.dart';
import '/models/match_date.dart';
import '/services/fixture_service.dart';
import '/services/match_date_service.dart';
import '/views/pages/sections/fixture/add_fixture.dart';

import '../../../../exports/exports.dart';
import 'fixture_results.dart';

class FixturesPage extends StatefulWidget {
  final String leagueId;
  final String leagueName;
  const FixturesPage(
      {super.key, required this.leagueId, required this.leagueName});

  @override
  State<FixturesPage> createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  Timer? _timer;
  TabController? _tabController;
  int tabs = 0;
  // function to capture current match date
  int currentTab(List<MatchDateModel> match) {
    var tabDate = match.where((element) =>
        DateTime.parse(element.date).formatedDate() ==
        DateTime.now().formatedDate());
    if (tabDate.isEmpty) {
      return (match.length - 1);
    }
    int tabIndex = match.indexOf(tabDate.first);
    return tabIndex;
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      var matchDates = await MatchDateService.getMatchDates(widget.leagueId);
      if (mounted && tabs == 0) {
        setState(() {
          tabs = context.read<DataController>().matchDates.length;
        });
        _tabController = TabController(
          length: matchDates.length, //P@ssw0rd?
          initialIndex: currentTab(matchDates),
          vsync: this,
        );
      } else {
        timer.cancel();
      }
    });
    context.read<DataController>().setLeagueId(widget.leagueId);
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();

    _tabController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  int x = 1;

  @override
  Widget build(BuildContext context) {
    // print("tabs ${_tabController?.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.leagueName}\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Fixtures",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      body: Consumer<DataController>(
        builder: (context, controller, child) {
          if (mounted) {
            if (tabs == 0) {
              x += 1;
              controller.setLeagueId(widget.leagueId);
              _tabController = TabController(
                vsync: this,
                length: tabs,
                animationDuration: const Duration(milliseconds: 600),
              );
            }
            if (controller.matchDates.isNotEmpty) {
              controller.fetchFixtureData(widget.leagueId,
                  controller.matchDates[_tabController?.index ?? 0].id);
            }
          }
          return Column(
            children: [
              if (_tabController?.length == controller.matchDates.length)
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: List.generate(
                    controller.matchDates.length,
                    (index) => Tab(
                      text: DateTime.parse(controller.matchDates[index].date)
                          .formatedDate(),
                    ),
                  ),
                ),
              if (_tabController?.length == controller.matchDates.length)
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: List.generate(
                      controller.matchDates.length,
                      (index) {
                        return controller.fixtureData.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.fixtureData.length,
                                itemBuilder: (context, index) {
                                  return FixtureWidget(
                                    homeTeam: controller
                                        .fixtureData[index].hometeam.name,
                                    awayTeam: controller
                                        .fixtureData[index].awayteam.name,
                                    homeTeamLogo: controller
                                        .fixtureData[index].hometeam.image,
                                    awayTeamLogo: controller
                                        .fixtureData[index].awayteam.image,
                                    onTap: () {
                                      Routes.animateToPage(
                                        FixtureResults(
                                          fixtureId:
                                              controller.fixtureData[index].id,
                                          data: controller.fixtureData[index],
                                          leagueId: widget.leagueId,
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      showAdaptiveDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog.adaptive(
                                              title:
                                                  const Text("Delete Fixture "),
                                              content: Text(
                                                "Are you sure you want to delete fixture for ${controller.fixtureData[index].awayteam.name} and  ${controller.fixtureData[index].hometeam.name} ",
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Routes.popPage(),
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    FixtureService
                                                        .deleteFixture(
                                                            controller
                                                                .fixtureData[
                                                                    index]
                                                                .id);
                                                  },
                                                  child: const Text("Delete"),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    kickOffTime: controller
                                        .fixtureData[index].kickofftime,
                                    isLive:
                                        controller.fixtureData[index].isLive,
                                    homeGoal:
                                        controller.fixtureData[index].homeGoals,
                                    awayGoal:
                                        controller.fixtureData[index].awayGoals,
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "No fixtures found",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              );
                      },
                    ),
                  ),
                )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            transitionAnimationController: _controller,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return AddFixture(
                      leagueId: widget.leagueId,
                    );
                  });
            }),
        label: Text(
          "Add a fixture",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
