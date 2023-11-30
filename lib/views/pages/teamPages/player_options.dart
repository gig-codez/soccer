import '../../../exports/exports.dart';
import '../../../models/player.dart';

class PlayerOptions extends StatefulWidget {
  final Message data;
  const PlayerOptions({super.key, required this.data});

  @override
  State<PlayerOptions> createState() => _PlayerOptionsState();
}

class _PlayerOptionsState extends State<PlayerOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 17, 0, 8),
            child: Text(
              "Options for ${widget.data.name}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Divider(),
          ),
          const ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text("Goal"),
          ),
          ListTile(
            leading: Icon(Icons.sports),
            title: Text("Assist"),
            trailing: Text(
              "0",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const ListTile(
            leading: SizedBox.square(
              dimension: 25,
              child: Card(
                color: Colors.yellow,
              ),
            ),
            title: Text(
              "Yellow card",
            ),
          ),
          const ListTile(
            leading: SizedBox.square(
              dimension: 25,
              child: Card(
                color: Colors.red,
              ),
            ),
            title: Text("Red card"),
            // trailing: Row(
            //   children: [],
            // ),
          ),
        ],
      ),
    );
  }
}
