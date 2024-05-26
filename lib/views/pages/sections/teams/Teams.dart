import 'package:samba_stats/controllers/team_controller.dart';

import '/views/pages/sections/widgets/league_options.dart';

import '/models/team.dart';
import '/services/team_service.dart';
import '../players/Players.dart';
import '/exports/exports.dart';
import 'update_team.dart';

class Teams extends StatefulWidget {
  final String? leagueId;
  final String? leagueName;
  const Teams({super.key, this.leagueId, this.leagueName, Message? league});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
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
            child: Consumer<TeamController>(
              builder: (context, teamController, s) {
                if (mounted) {
                  teamController.getTeams(widget.leagueId ?? "");
                }
                return teamController.loading == false
                    ? teamController.teams.isNotEmpty
                        ? ListView.builder(
                            itemCount: teamController.teams.length,
                            itemBuilder: (context, index) {
                              return ProfileWidget(
                                titleText: teamController.teams[index].name,
                                img: teamController.teams[index].image,
                                onPress: () {
                                  Routes.animateToPage(
                                    Players(
                                      teamId: teamController.teams[index].id,
                                      teamName:
                                          teamController.teams[index].name,
                                      leagueId: widget.leagueId,
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
                                                  team: teamController
                                                      .teams[index],
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
                                                  teamController
                                                      .teams[index].id),
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
