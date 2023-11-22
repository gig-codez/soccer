import 'dart:async';

import '../../widgets/LeagueWidget.dart';
import '/models/league.dart';
import '/services/league_service.dart';
import '/widgets/DrawerWidget.dart';
import '/widgets/LeagueCard.dart';
import '/exports/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: const Text('Samba Stats'),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: FutureBuilder(
          future: LeagueService().getLeague(),
          builder: (context, snap) {
            var d = snap.data;
            return snap.hasData
                ? d != null && d.isNotEmpty
                    ? ListView.builder(
                        itemCount: d.length,
                        itemBuilder: (context, leagueData) {
                          return LeagueWidget(
                            data: d[leagueData],
                          );
                        })
                    : const Center(
                        child: Text("No fixture yet set for today!"),
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
