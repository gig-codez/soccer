import 'package:soccer/views/pages/sections/updatePlayer.dart';

import '../../../../exports/exports.dart';
import '../../../../models/player.dart';
import '../transfer_widget.dart';

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
      height: 300,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Player options",
              style: Theme.of(context).textTheme.headline6,
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
          ],
        ),
      ),
    );
  }
}
