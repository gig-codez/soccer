import '/models/fixture.dart';
import '/services/fixture_service.dart';
import "dart:async";
import '../exports/exports.dart';

class PlayingTeams extends StatefulWidget {
  final Datum data;
  const PlayingTeams({super.key, required this.data});

  @override
  State<PlayingTeams> createState() => _PlayingTeamsState();
}

class _PlayingTeamsState extends State<PlayingTeams> {
  StreamController<Datum> fixtureController = StreamController<Datum>();
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      FixtureService.getFixtures(widget.data.league).then((value) {
        fixtureController
            .add(value.where((element) => element.id == widget.data.id).first);
      });
    });
  }

  @override
  void dispose() {
    if (fixtureController.hasListener) {
      fixtureController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fixtureController.stream,
        builder: (context, snapshot) {
          var fixtureData = snapshot.data ?? widget.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.data.hometeam.image,
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Text(widget.data.hometeam.name,
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
              if (snapshot.hasData)
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: fixtureData.isRunning
                                ? fixtureData.elapsedTime
                                : (fixtureData.halfEnded == true) &&
                                        (fixtureData.matchEnded == false)
                                    ? "HT\n"
                                    : (fixtureData.halfEnded == true) &&
                                            (fixtureData.matchEnded == true)
                                        ? "FT\n"
                                        : "${fixtureData.kickofftime}\n",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          // TextSpan(
                          //   text: "Full-Time",
                          //   style: Theme.of(context).textTheme.titleMedium,
                          // ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.data.awayteam.image,
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Text(widget.data.awayteam.name,
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
