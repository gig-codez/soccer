import '/exports/exports.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/leagues/komafo.jpeg",
                width: 35,
                height: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                "0 - 0",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/leagues/amigos.jpeg",
                width: 35,
                height: 35,
              ),
            ),
          ],
        ),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Card(
              child: Row(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
