import '../../../exports/exports.dart';

class PlayerOptions extends StatefulWidget {
  const PlayerOptions({super.key});

  @override
  State<PlayerOptions> createState() => _PlayerOptionsState();
}

class _PlayerOptionsState extends State<PlayerOptions> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text("Goal"),
          ),
          ListTile(
            leading: Icon(Icons.sports),
            title: Text("Assist"),
          ),
          ListTile(
            leading: SizedBox.square(
              dimension: 25,
              child: Card(
                color: Colors.yellow,
              ),
            ),
            title: Text(
              "Yellow",
            ),
          ),
          // 11:00
          ListTile(
            leading: SizedBox.square(
              dimension: 25,
              child: Card(
                color: Colors.red,
              ),
            ),
            title: Text("Red"),
            trailing: Row(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
