import 'package:soccer/views/pages/teamPages/components/add_assist.dart';

import '/exports/exports.dart';
import '/models/player.dart';
import 'components/goal_widget.dart';
import 'components/red_card.dart';
import 'components/yellow_card_widget.dart';

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
          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: const Text("Goal"),
            trailing: Text(
              widget.data.goal.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              showModalSheet(
                GoalWidget(
                  playerId: widget.data.id,
                  leagueId: widget.leagueId,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports),
            title: const Text("Assist"),
            trailing: Text(
              "N/A",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              showModalSheet(
                AddAssist(
                  playerId: widget.data.id,
                  leagueId: widget.leagueId,
                  teamId: widget.data.team,
                ),
              );
            },
          ),
          ListTile(
            leading: const SizedBox.square(
              dimension: 25,
              child: Card(
                color: Colors.yellow,
              ),
            ),
            trailing: Text(
              widget.data.yellow.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            title: const Text(
              "Yellow card",
            ),
            onTap: () {
              showModalSheet(
                YellowCardWidget(
                  playerId: widget.data.id,
                  leagueId: widget.leagueId,
                ),
              );
            },
          ),
          ListTile(
            leading: const SizedBox.square(
              dimension: 25,
              child: Card(
                color: Colors.red,
              ),
            ),
            title: const Text("Red card"),
            trailing: Text(
              widget.data.red.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              showModalSheet(
                RedCard(
                  playerId: widget.data.id,
                  leagueId: widget.leagueId,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
