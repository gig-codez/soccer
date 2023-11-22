import 'package:soccer/models/fixture.dart';

import '../exports/exports.dart';

class PlayingTeams extends StatelessWidget {
  final Datum data;
  const PlayingTeams({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                  Apis.image + data.hometeam.image,
                  width: 55,
                  height: 55,
                ),
              ),
              Text(data.hometeam.name,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: data.isLive
                        ? "${data.homeGoals} - ${data.awayGoals}"
                        : "${data.kickofftime}\n",
                    style: Theme.of(context).textTheme.titleLarge,
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
                  Apis.image + data.awayteam.image,
                  width: 55,
                  height: 55,
                ),
              ),
              Text(data.awayteam.name,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}
