import 'package:soccer/views/pages/sections/updatePlayer.dart';

import '../../../../exports/exports.dart';
import '../../../../models/player.dart';
import '../transfer_widget.dart';

import '/views/pages/teamPages/components/add_assist.dart';
import '/views/pages/teamPages/components/clean_sheet.dart';
import '/views/pages/teamPages/components/goal_widget.dart';
import '/views/pages/teamPages/components/red_card.dart';
import '/views/pages/teamPages/components/yellow_card_widget.dart';

class POptions extends StatefulWidget {
  final Message player;
  final String teamId;
  final String leagueId;
  const POptions(
      {super.key,
      required this.player,
      required this.teamId,
      required this.leagueId});

  @override
  State<POptions> createState() => _POptionsState();
}

class _POptionsState extends State<POptions> with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
        children: [
          Text(
            "Player options",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Divider(),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit player"),
            onTap: () {
              Routes.popPage();
              showModalSheet(
                UpdatePlayer(
                    name: widget.player.name,
                    position: widget.player.position,
                    id: widget.player.id,
                    teamId: widget.teamId),
                controller: _controller,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.transfer_within_a_station_outlined),
            title: const Text("Transfer player"),
            onTap: () {
              Routes.popPage();
              showModalSheet(
                TransferWidget(
                  teamId: widget.teamId,
                  playerId: widget.player.id,
                  leagueId: widget.leagueId,
                ),
                controller: _controller,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.transfer_within_a_station_outlined),
            title: const Text("Clean sheet"),
            trailing: Text(
              widget.player.cleanSheet.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Routes.popPage();
              showAdaptive(
                CleanSheetWidget(
                  playerId: widget.player.id,
                  leagueId: widget.leagueId,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports_soccer),
            title: const Text("Goal"),
            trailing: Text(
              widget.player.goal.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Routes.popPage();
              showAdaptive(
                GoalWidget(
                  playerId: widget.player.id,
                  leagueId: widget.leagueId,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.sports),
            title: const Text("Assist"),
            trailing: Text(
              widget.player.assist,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Routes.popPage();
              showAdaptive(
                AddAssist(
                  playerId: widget.player.id,
                  leagueId: widget.leagueId,
                  teamId: widget.player.team.id,
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
              widget.player.yellow.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            title: const Text(
              "Yellow card",
            ),
            onTap: () {
              Routes.popPage();
              showAdaptive(
                YellowCardWidget(
                  playerId: widget.player.id,
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
              widget.player.red.toString(),
              // widget.data.red.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              Routes.popPage();
              showAdaptive(
                RedCard(
                  playerId: widget.player.id,
                  leagueId: widget.leagueId,
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 75),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
