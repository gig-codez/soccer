import 'dart:async';

import '/models/team.dart';
import '/services/team_service.dart';
import '/views/pages/sections/Players.dart';
import '/views/pages/sections/add_team.dart';

import '/exports/exports.dart';

class Teams extends StatefulWidget {
  final String? leagueId;
  final String? leagueName;
  const Teams({super.key, this.leagueId, this.leagueName, Message? league});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  final StreamController<List<Message>> _leaguesController =
      StreamController<List<Message>>();
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
  }

  @override
  void dispose() {
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
                                img: Apis.image + "${snap.data?[index].image}",
                                onPress: () {
                                  Routes.animateToPage(
                                    Players(
                                      teamId: snap.data?[index].id,
                                      teamName: snap.data?[index].name,
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
            context: context,
            builder: (context) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return AddTeam(leagueId: widget.leagueId);
                  });
            }),
        label: const Text("Add a team"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
