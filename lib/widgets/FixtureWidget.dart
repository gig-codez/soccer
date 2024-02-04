import '/exports/exports.dart';

class FixtureWidget extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final GestureLongPressCallback? onLongPress;
  final bool isLive;
  final int homeGoal;
  final int awayGoal;
  final String homeTeamLogo;
  final String kickOffTime;
  final String awayTeamLogo;
  final VoidCallback onTap;
  const FixtureWidget(
      {super.key,
      required this.homeTeam,
      required this.awayTeam,
      required this.homeTeamLogo,
      required this.awayTeamLogo,
      required this.onTap,
      this.onLongPress,
      required this.kickOffTime,
      required this.isLive,
      required this.homeGoal,
      required this.awayGoal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 0,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade100
            : Colors.white12,
        margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        "$homeTeam  ",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        homeTeamLogo,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 2.0, 15, 2.0),
                  child: Text(
                    isLive ? "$homeGoal - $awayGoal" : kickOffTime,
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        awayTeamLogo,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        "   $awayTeam",
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
