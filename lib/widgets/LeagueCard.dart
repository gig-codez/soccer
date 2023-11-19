import 'dart:async';

import 'package:soccer/models/fixture.dart';
import 'package:soccer/models/league.dart';

import '../exports/exports.dart';
import '../services/fixture_service.dart';
import 'FixtureWidget.dart';

class LeagueCard extends StatelessWidget {
  final List<Message> data;
  const LeagueCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : Colors.white12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade100
                : Colors.white12,
            width: 2),
      ),
      child: Accordion(
        headerBorderColorOpened: Colors.transparent,
        headerBorderWidth: 1,
        contentBorderWidth: 1,
        contentBackgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        contentHorizontalPadding: 10,
        scaleWhenAnimating: false,
        openAndCloseAnimation: false,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: List.generate(
          data.length,
          (index) => AccordionSection(
              isOpen: index == 0,
              contentVerticalPadding: 10,
              leftIcon:
                  const Icon(Icons.sports_basketball, color: Colors.white),
              header: Text(
                data[index].name,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white),
              ),
              content: HomeFixtureWidget(
                leagueId: data[index].id,
              )),
        ),
      ),
    );
  }
}

class HomeFixtureWidget extends StatefulWidget {
  final String leagueId;
  const HomeFixtureWidget({super.key, required this.leagueId});

  @override
  State<HomeFixtureWidget> createState() => _HomeFixtureWidgetState();
}

class _HomeFixtureWidgetState extends State<HomeFixtureWidget> {
  final StreamController<List<Datum>> _leaguesController =
      StreamController<List<Datum>>();
  Timer? _timer;

  void fetchLeagues() async {
    var leagues = await FixtureService.getFixtures(widget.leagueId);
    _leaguesController.add(leagues);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var leagues = await FixtureService.getFixtures(widget.leagueId);
      _leaguesController.add(leagues);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLeagues();
  }

  @override
  void dispose() {
    if (_leaguesController.hasListener) {
      _leaguesController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _leaguesController.stream,
        builder: (context, s) {
          return s.hasData
              ? s.data != null && s.data!.isNotEmpty
                  ? Column(
                      children: List.generate(s.data!.length, (index) {
                        return FixtureWidget(
                          homeTeam: s.data![index].hometeam.name,
                          awayTeam:
                              s.data![index].awayteam.name.split(" ").first,
                          homeTeamLogo: s.data![index].hometeam.image,
                          awayTeamLogo: s.data![index].awayteam.image,
                          onTap: () {
                            Routes.animateToPage(
                                TeamsPage(data: s.data![index]));
                          },
                          kickOffTime: s.data![index].kickofftime,
                        );
                      }),
                    )
                  : const Center(
                      child: Text("No fixtues"),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        });
  }
}
