import '/services/team_service.dart';

import '../../../exports/exports.dart';

class AwayTeamsWidget extends StatefulWidget {
  final String leagueId;
  const AwayTeamsWidget({super.key, required this.leagueId});

  @override
  State<AwayTeamsWidget> createState() => _AwayTeamsWidgetState();
}

class _AwayTeamsWidgetState extends State<AwayTeamsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Away Teams"),
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
                                context.read<AppController>().awayTeamData = {
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
