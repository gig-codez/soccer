import '/exports/exports.dart';

class FixtureWidget extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final GestureLongPressCallback? onLongPress;
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
      required this.kickOffTime});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "$homeTeam  ",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        Apis.image + homeTeamLogo,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  kickOffTime,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        Apis.image + awayTeamLogo,
                        width: 30,
                        height: 30,
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
