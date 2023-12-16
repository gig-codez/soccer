// import 'package:soccer/services/league_service.dart';
import 'package:soccer/services/team_service.dart';

import '../../../exports/exports.dart';

class ShowLeagues extends StatefulWidget {
  final String leagueId;
  const ShowLeagues({super.key, required this.leagueId});

  @override
  State<ShowLeagues> createState() => _ShowLeaguesState();
}

class _ShowLeaguesState extends State<ShowLeagues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Home Teams"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: FutureBuilder(
            future: TeamService().getTeams(widget.leagueId),
            builder: (context, snap) {
              return snap.hasData
                  ? snap.data != null && snap.data!.isNotEmpty
                      ? ListView.builder(
                          itemCount: snap.data!.length,
                          itemBuilder: (context, index) {
                            return ProfileWidget(
                              titleText: "${snap.data?[index].name}",
                              prefixIcon: "assets/icons/league.svg",
                              onPress: () {
                                context.read<AppController>().homeTeamData = {
                                  'name': snap.data?[index].name,
                                  'id': snap.data?[index].id
                                };
                                Routes.popPage();
                              },
                              iconSize: 30,
                              color: Colors.blue,
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
    );
  }
}
