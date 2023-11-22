import 'package:soccer/models/fixture.dart';

import '../exports/exports.dart';

class TeamsWidget extends StatelessWidget {
  final Datum fixtureData;
  final VoidCallback? onTap;
  const TeamsWidget({
    super.key,
    required this.fixtureData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onClick: onTap ?? () {},
      child: Card(
        elevation: 0,
        color: Colors.grey[200],
        child: SizedBox(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "FT",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            Apis.image + fixtureData.hometeam.image,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        Text(fixtureData.hometeam.name),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            Apis.image + fixtureData.awayteam.image,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        Text(fixtureData.awayteam.name),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: fixtureData.isLive
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            fixtureData.homeGoals.toString(),
                          ),
                          Text(
                            fixtureData.awayGoals.toString(),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(fixtureData.kickofftime),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
