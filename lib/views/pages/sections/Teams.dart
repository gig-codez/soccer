import 'dart:async';

import 'package:soccer/views/pages/sections/widgets/league_options.dart';

import '/models/team.dart';
import '/services/team_service.dart';
import '/views/pages/sections/Players.dart';
import '/views/pages/sections/add_team.dart';

import '/exports/exports.dart';
import 'widgets/update_team.dart';

class Teams extends StatefulWidget {
  final String? leagueId;
  final String? leagueName;
  const Teams({super.key, this.leagueId, this.leagueName, Message? league});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> with SingleTickerProviderStateMixin {
  final StreamController<List<Message>> _leaguesController =
      StreamController<List<Message>>();

  AnimationController? _controller;

  Timer? _timer;
  void fetchLeagues() async {
    var leagues = await TeamService().getTeams(widget.leagueId ?? "");
    _leaguesController.add(leagues);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var leagues = await TeamService().getTeams(widget.leagueId ?? "");
      _leaguesController.add(leagues);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLeagues();
    _controller = AnimationController(
      value: 0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    if (_leaguesController.hasListener) {
      _leaguesController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.leagueName}\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Teams",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
            child: StreamBuilder(
              stream: _leaguesController.stream,
              builder: (context, snap) {
                return snap.hasData
                    ? snap.data != null && snap.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: snap.data?.length,
                            itemBuilder: (context, index) {
                              return ProfileWidget(
                                titleText: "${snap.data?[index].name}",
                                img: "${Apis.image}${snap.data?[index].image}",
                                onPress: () {
                                  Routes.animateToPage(
                                    Players(
                                      teamId: snap.data?[index].id,
                                      teamName: snap.data?[index].name,
                                    ),
                                  );
                                },
                                trailing: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        transitionAnimationController:
                                            _controller,
                                        showDragHandle: true,
                                        context: context,
                                        builder: (context) {
                                          return BottomSheet(
                                              animationController: _controller,
                                              onClosing: () {},
                                              builder: (context) {
                                                return UpdateTeam(
                                                  leagueId: widget.leagueId!,
                                                  team: snap.data![index],
                                                );
                                              });
                                        });
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                onLongPress: () {
                                  showAdaptiveDialog(
                                    context: context,
                                    builder: (context) => AlertDialog.adaptive(
                                      title: const Text("Delete Team"),
                                      content: const Text(
                                          "Are you sure you want to delete this team?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Routes.popPage(),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              TeamService.deleteTeam(
                                                  snap.data![index].id),
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : const Center(
                            child: Text("No Team found"),
                          )
                    : const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            showDragHandle: true,
            transitionAnimationController: _controller,
            context: context,
            builder: (context) {
              return BottomSheet(
                  animationController: _controller,
                  onClosing: () {},
                  builder: (context) {
                    return LeagueOptions(
                      leagueId: widget.leagueId!,
                      leagueName: widget.leagueName!,
                    );
                  });
            }),
        label: const Text("More"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
