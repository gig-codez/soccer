import 'dart:async';

import '/models/fixture.dart';
import '/models/league.dart';
import '/widgets/TeamsWidget.dart';

import '../exports/exports.dart';
import '../services/fixture_service.dart';

class LeagueCard extends StatelessWidget {
  final List<Message> data;
  const LeagueCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Accordion(
      headerBorderColorOpened: Colors.transparent,
      headerBorderWidth: 1,
      contentBorderWidth: 1,
      contentBackgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      contentHorizontalPadding: 0,
      scaleWhenAnimating: false,
      openAndCloseAnimation: false,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      children: List.generate(
        data.length,
        (index) => AccordionSection(
            isOpen: index == 0,
            contentVerticalPadding: 10,
            headerBackgroundColor: Colors.grey.shade200,
            contentBorderColor: Colors.grey.shade200,
            leftIcon: const Icon(Icons.sports_basketball, color: Colors.black),
            header: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Text(
                data[index].name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: Colors.black, fontWeightDelta: 2),
              ),
            ),
            content: HomeFixtureWidget(
              leagueId: data[index].id,
            )),
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
    // fetchLeagues();
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
                        return TeamsWidget(
                          fixtureData: s.data![index],
                          onTap: () {
                            Routes.animateToPage(
                              TeamsPage(
                                data: s.data![index],
                              ),
                            );
                          },
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
