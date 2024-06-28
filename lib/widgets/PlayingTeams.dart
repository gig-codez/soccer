import 'package:samba_stats/controllers/fixture_controller.dart';

import '/models/fixture.dart';
// import '/services/fixture_service.dart';
// import "dart:async";
import '../exports/exports.dart';

class PlayingTeams extends StatefulWidget {
  final Datum data;
  const PlayingTeams({super.key, required this.data});

  @override
  State<PlayingTeams> createState() => _PlayingTeamsState();
}

class _PlayingTeamsState extends State<PlayingTeams> {
  // StreamController<Datum> fixtureController = StreamController<Datum>();
  // Timer? _timer;
  @override
  void initState() {
    super.initState();
    Provider.of<FixtureController>(context, listen: false)
        .fetchFixtureData(widget.data.league, widget.data.id);
  }

  @override
  void dispose() {
    // Provider.of<FixtureController>(context, listen: false).dispose();
    super.dispose();
  }

  // helper function
  String quarterTimes(Datum data) {
    return data.quarterEnded
        ? "QT"
        : data.halfEnded
            ? "HT"
            : data.secondHalfEnded == true
                ? "TQT"
                : data.matchEnded == true
                    ? "FT"
                    : "${data.kickofftime}\n";
  }

  String halfTimes(Datum data) {
    return (data.halfEnded == true) && (data.matchEnded == false)
        ? "HT\n"
        : (data.halfEnded == true) && (data.matchEnded == true)
            ? "FT\n"
            : "${data.kickofftime}\n";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FixtureController>(
        builder: (context, fixtureController, snapshot) {
      fixtureController.fetchFixtureData(widget.data.league, widget.data.id);
      var fixtureData = fixtureController.fixtureData;
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
          // ignore: unnecessary_null_comparison
          if (fixtureData != null)
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
                            : fixtureData.twohalves
                                ? halfTimes(fixtureData)
                                : quarterTimes(fixtureData),
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
