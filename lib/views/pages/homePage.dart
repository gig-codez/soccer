import 'dart:async';

import 'package:soccer/widgets/FixtureWidget.dart';

import '../../models/fixture.dart';
import '../../models/league.dart';
import '../../services/fixture_service.dart';
import '../../services/league_service.dart';
import '../../widgets/DrawerWidget.dart';
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
            return snap.hasData
                ? snap.data != null && snap.data!.isNotEmpty
                    ? LeagueCard(
                        data: snap.data ?? [],
                      )
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
