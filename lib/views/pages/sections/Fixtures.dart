import 'dart:async';

import 'package:soccer/models/fixture.dart';
import 'package:soccer/widgets/FixtureWidget.dart';

import '../../../services/fixture_service.dart';
import '/views/pages/sections/add_fixture.dart';

import '../../../exports/exports.dart';
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
  final StreamController<List<Datum>> _fixtureStreaData =
      StreamController<List<Datum>>();
  Timer? _timer;

  void fetchCurrentData() async {
    var streamData = await FixtureService.getFixtures(widget.leagueId);
    _fixtureStreaData.add(streamData);
    // refresh the api for new entries
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      var streamData = await FixtureService.getFixtures(widget.leagueId);
      _fixtureStreaData.add(streamData);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 500),
    );
    fetchCurrentData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    if (_fixtureStreaData.hasListener) {
      _fixtureStreaData.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
        stream: _fixtureStreaData.stream,
        builder: (context, snap) {
          return snap.hasData
              ? snap.data != null && snap.data!.isNotEmpty
                  ? ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) => FixtureWidget(
                        homeTeam: snap.data![index].hometeam.name,
                        awayTeam: snap.data![index].awayteam.name,
                        homeTeamLogo: snap.data![index].hometeam.image,
                        awayTeamLogo: snap.data![index].awayteam.image,
                        onTap: () {
                          Routes.animateToPage(
                            FixtureResults(
                              fixtureId: snap.data![index].id,
                              data: snap.data![index],
                              leagueId: widget.leagueId,
                            ),
                          );
                        },
                        onLongPress: () {
                          showAdaptiveDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog.adaptive(
                                  title: const Text("Delete Fixture "),
                                  content: Text(
                                    "Are you sure you want to delete fixture for ${snap.data![index].awayteam.name} and  ${snap.data![index].hometeam.name} ",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Routes.popPage(),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FixtureService.deleteFixture(
                                            snap.data![index].id);
                                      },
                                      child: const Text("Delete"),
                                    )
                                  ],
                                );
                              });
                        },
                        kickOffTime: snap.data![index].kickofftime,
                        isLive: snap.data![index].isLive,
                        homeGoal: snap.data![index].homeGoals,
                        awayGoal: snap.data![index].awayGoals,
                      ),
                    )
                  : Center(
                      child: Text("No fixtures found",
                          style: Theme.of(context).textTheme.titleLarge),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
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
