import 'dart:async';
import 'dart:developer';

// import '../teamPages/player_options.dart';
import 'package:samba_stats/views/pages/sections/widgets/hand_ball_options.dart';

import '../../test.dart';
import '/exports/exports.dart';
import '/models/player.dart';
import '/services/player_service.dart';
import 'add_player.dart';
import '../transfers/transfer_widget.dart';
import 'updatePlayer.dart';
import '../widgets/p_options.dart';

class Players extends StatefulWidget {
  final String? teamId;
  final String? teamName;
  final String? leagueId;
  const Players({
    super.key,
    this.teamId,
    this.teamName,
    this.leagueId,
  });

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> with TickerProviderStateMixin {
  final playerController = TextEditingController();
  final StreamController<List<Message>> _leaguesController =
      StreamController<List<Message>>();
  Timer? _timer;
  AnimationController? _controller;
  void fetchLeagues() async {
    var leagues = await PlayerService().getPlayers(widget.teamId ?? "");
    _leaguesController.add(leagues);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var leagues = await PlayerService().getPlayers(widget.teamId ?? "");
      _leaguesController.add(leagues);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLeagues();
    _controller = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    if (_leaguesController.hasListener) {
      _leaguesController.close();
    }
    _controller?.dispose();
    _timer?.cancel();
    playerController.dispose();
    super.dispose();
  }

  int players = 0;
  @override
  Widget build(BuildContext context) {
    // log(widget.teamId ?? "");
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.teamName}\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Players",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: Text(
                        "Provide number of players",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: TextFormField(
                        controller: playerController,
                        onChanged: (x) {
                          setState(() {
                            playerController.text = x;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Players",
                          hintText: "Enter number of players",
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Routes.popPage(),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Routes.popPage();
                            setState(() {
                              players = int.parse(playerController.text);
                            });
                            // handle creating multiple players
                            for (int i = 0; i < players; i++) {
                              Future.delayed(const Duration(seconds: 2));
                              PlayerService.createPlayer({
                                "name": "Player ${i + 1}",
                                "team": widget.teamId,
                                "position": "Position ${i + 1}",
                                "goal": "0",
                                "assist": "0",
                                "yellow": "0",
                                "red": "0"
                              });
                              Future.delayed(const Duration(seconds: 2));
                            }
                            showMessage(
                                msg: "$players Players added successfully");
                          },
                          child: const Text("Add Players"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _leaguesController.stream,
          builder: (context, snap) {
            return snap.hasData
                ? snap.data != null && snap.data!.isNotEmpty
                    ? ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: const CircleAvatar(
                            child: Text("P"),
                          ),
                          subtitle: Text("${snap.data?[index].position}"),
                          onLongPress: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: const Text("Delete Player!"),
                                content: Text(
                                    "Are you sure you want to delete this ${snap.data?[index].name}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Routes.popPage(),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      PlayerService.deletePlayer(
                                          snap.data![index].id);
                                    },
                                    child: const Text("Delete"),
                                  )
                                ],
                              ),
                            );
                          },
                          trailing: IconButton(
                            onPressed: () {
                              String league1 = "667a7dfe69692a12fae2c2a9";
                              String league2 = "667a7d9769692a12fae2c16b";
                              if (widget.leagueId != null) {
                                if (widget.leagueId == league2 ||
                                    widget.leagueId == league1) {
                                       showModalSheet(
                                    POptions(
                                      player: snap.data![index],
                                      teamId: widget.teamId!,
                                      leagueId: widget.leagueId!,
                                    ),
                                    controller: _controller,
                                  );
                                  // Routes.animateToPage(
                                  //   HandBallOptions(
                                  //     playerId: snap.data![index].id,
                                  //     leagueId: widget.leagueId!,
                                  //   ),
                                  // );
                                } else {
                                  showModalSheet(
                                    POptions(
                                      player: snap.data![index],
                                      teamId: widget.teamId!,
                                      leagueId: widget.leagueId!,
                                    ),
                                    controller: _controller,
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.edit_rounded),
                          ),
                          title: Text("${snap.data?[index].name}"),
                        ),
                      )
                    : Center(
                        child: Text(
                          "No players added yet",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
          },
        ),
      ),
    );
  }
}

class PlayersListWidget extends StatelessWidget {
  final List<Message> players;
  const PlayersListWidget({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return players.isEmpty
        ? ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) => ListTile(
              leading: const CircleAvatar(
                child: Text("P"),
              ),
              trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return AddPlayer(
                              name: players[index].name,
                              position: players[index].position,
                            );
                          },
                        );
                      });
                },
                icon: const Icon(Icons.edit_rounded),
              ),
              title: Text(players[index].name),
            ),
          )
        : Center(
            child: Text(
              "No players added yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
  }
}
