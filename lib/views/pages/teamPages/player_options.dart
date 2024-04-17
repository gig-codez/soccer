import '/exports/exports.dart';
import '/models/player.dart';

class PlayerOptions extends StatefulWidget {
  final Message data;
  final String leagueId;
  const PlayerOptions({super.key, required this.data, required this.leagueId});

  @override
  State<PlayerOptions> createState() => _PlayerOptionsState();
}

class _PlayerOptionsState extends State<PlayerOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
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
        ],
      ),
    );
  }
}
