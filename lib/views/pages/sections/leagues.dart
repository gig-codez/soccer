import 'dart:async';

import '../../../models/league.dart';
import '../../../services/league_service.dart';
import '/exports/exports.dart';
import 'Teams.dart';
import 'add_league.dart';

class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  final StreamController<List<Message>> _leaguesController =
      StreamController<List<Message>>();
  Timer? _timer;

  void fetchLeagues() async {
    var leagues = await LeagueService().getLeague();
    _leaguesController.add(leagues);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var leagues = await LeagueService().getLeague();
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
        title: const Text("Leagues"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 8, 13, 0),
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
                              prefixIcon: "assets/icons/league.svg",
                              iconSize: 20,
                              color: Theme.of(context).primaryColor,
                              onPress: () {
                                Routes.animateToPage(
                                  Teams(
                                    leagueId: snap.data?[index].id,
                                    leagueName: snap.data?[index].name,
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text("No league found"),
                        )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return BottomSheet(
                    onClosing: () {},
                    builder: (context) {
                      return const AddLeague();
                    });
              });
        },
        label: Text(
          "Add league",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
