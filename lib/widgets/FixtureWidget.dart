import '/exports/exports.dart';

class FixtureWidget extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;

  final String homeTeamLogo;
  final String awayTeamLogo;
  final VoidCallback onTap;
  const FixtureWidget(
      {super.key,
      required this.homeTeam,
      required this.awayTeam,
      required this.homeTeamLogo,
      required this.awayTeamLogo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "$homeTeam  ",
                style: Theme.of(context).textTheme.bodySmall,
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
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              "0 - 0",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  Apis.image + awayTeamLogo,
                  width: 30,
                  height: 30,
                ),
              ),
              Text(
                "   $awayTeam",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
