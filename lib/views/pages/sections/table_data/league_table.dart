import 'TableResults.dart';

import '/models/league.dart';
import '/services/league_service.dart';
import '/exports/exports.dart';
import 'dart:async';

class LeagueTable extends StatefulWidget {
  const LeagueTable({super.key});

  @override
  State<LeagueTable> createState() => _LeagueTableState();
}

class _LeagueTableState extends State<LeagueTable> {
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
        title: const Text("Select a league"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _leaguesController.stream,
          builder: (context, snap) {
            return snap.hasData
                ? snap.data != null && snap.data!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: snap.data?.length,
                          itemBuilder: (context, index) {
                            return ProfileWidget(
                              titleText: "${snap.data?[index].name}",
                              prefixIcon: "assets/icons/league.svg",
                              size: 25,
                              iconSize: 25,
                              color: Theme.of(context).primaryColor,
                              onPress: () {
                                Routes.animateToPage(
                                  TableResults(
                                    leagueId: snap.data![index].id,
                                    // leagueName: snap.data![index].name,
                                  ),
                                );
                              },
                            );
                          },
                        ),
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
    );
  }
}
