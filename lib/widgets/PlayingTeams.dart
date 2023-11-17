import '../exports/exports.dart';

class PlayingTeams extends StatelessWidget {
  const PlayingTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/leagues/komafo.jpeg",
                width: 55,
                height: 55,
              ),
            ),
            Text("Komafo", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "0 - 0\n",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextSpan(
                  text: "Full-Time",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/leagues/amigos.jpeg",
                width: 55,
                height: 55,
              ),
            ),
            Text("AMIGOS", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
