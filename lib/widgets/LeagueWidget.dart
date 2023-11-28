import 'dart:async';

import '../services/fixture_service.dart';
import '/exports/exports.dart';
import '/models/fixture.dart';
import '/models/league.dart';

class LeagueWidget extends StatefulWidget {
  final Message data;
  final String matchId;

  const LeagueWidget({
    super.key,
    required this.data,
    required this.matchId,
  });

  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends State<LeagueWidget> {
  final StreamController<List<Datum>> _leaguesController =
      StreamController<List<Datum>>();
  Timer? _timer;
  bool showHide = true;
  void fetchLeagues() async {
    var leagues =
        await FixtureService.getRunningFixtures(widget.data.id, widget.matchId);
    _leaguesController.add(leagues);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var leagues = await FixtureService.getRunningFixtures(
          widget.data.id, widget.matchId);
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
    FixtureService.getRunningFixtures(widget.data.id, widget.matchId).then((x) {
      if (mounted) {
        if (x.isEmpty) {
          setState(() {
            showHide = false;
          });
        } else {
          setState(() {
            showHide = true;
          });
        }
      }
    });
    return showHide
        ? FutureBuilder(
            future: FixtureService.getRunningFixtures(
                widget.data.id, widget.matchId),
            builder: (context, snapshot) {
              var _data = snapshot.data;
              return snapshot.hasData
                  ? Container(
                      // height: MediaQuery.of(context).size.height * 0.7,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      margin: const EdgeInsets.fromLTRB(10, 11, 10, 11),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        children: [
                          _cardHeader(title: widget.data.name),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          if (_data != null && _data.isNotEmpty)
                            ...List.generate(
                              _data.length,
                              (i) => cardContent(fixture: _data[i]),
                            ),
                          if (_data != null && _data.isEmpty)
                            const Center(
                              child: Text("No fixtures"),
                            )
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
            },
          )
        : const SizedBox();
  }
}
/**
 *                    
 */

// card header
Widget _cardHeader({String? title, String? leagueLogo}) {
  BuildContext? context = navigatorKey.currentContext;
  return FittedBox(
    child: SizedBox(
      width: MediaQuery.of(context!).size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: leagueLogo == null
                  ? Image.asset(
                      "assets/images/ball.png",
                      width: 50,
                      height: 50,
                    )
                  : Image.network(
                      Apis.image + leagueLogo,
                      width: 50,
                      height: 50,
                    ),
            ),
            Text(
              title ?? "League name",
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                    fontWeightDelta: 5,
                    fontSizeDelta: 3,
                  ),
            ),
            const SizedBox.square(
              dimension: 60,
              child: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    ),
  );
}

Widget cardContent({Datum? fixture}) {
  BuildContext? context = navigatorKey.currentContext;
  TextStyle textStyle = Theme.of(context!)
      .textTheme
      .labelLarge!
      .apply(fontWeightDelta: 5, fontSizeDelta: 3);
  return TapEffect(
    onClick: () {
      Routes.animateToPage(
        TeamsPage(
          data: fixture,
        ),
      );
    },
    child: SizedBox(
      height: 140,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: 20,
                  child: Text(
                    fixture!.isLive ? "FT" : fixture.kickofftime,
                    style: textStyle.copyWith(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                Apis.image + fixture!.hometeam.image,
                                width: 44,
                                height: 44,
                              ),
                            ),
                            const SizedBox.square(
                              dimension: 14,
                            ),
                            SizedBox(
                              width: 170,
                              child: Text(
                                fixture.hometeam.name,
                                style: textStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox.square(
                          dimension: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                Apis.image + fixture.awayteam.image,
                                width: 44,
                                height: 44,
                              ),
                            ),
                            const SizedBox.square(
                              dimension: 20,
                            ),
                            SizedBox(
                              width: 170,
                              child: Text(
                                fixture.awayteam.name,
                                style: textStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 20,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "${fixture.homeGoals}\n"),
                        TextSpan(text: "\n ${fixture.awayGoals}"),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
        ],
      ),
    ),
  );
}
