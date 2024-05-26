import 'package:samba_stats/controllers/team_controller.dart';

import '/exports/exports.dart';

class AwayTeamsWidget extends StatefulWidget {
  final String leagueId;
  const AwayTeamsWidget({super.key, required this.leagueId});

  @override
  State<AwayTeamsWidget> createState() => _AwayTeamsWidgetState();
}

class _AwayTeamsWidgetState extends State<AwayTeamsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Consumer<TeamController>(
        builder: (context, controller, snap) {
          if (mounted == true) {
            controller.getTeams(widget.leagueId);
          }
          return controller.loading == false
              ? controller.awayTeams.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.awayTeams.length,
                      itemBuilder: (context, index) {
                        return ProfileWidget(
                          titleText: controller.awayTeams[index].name,
                          prefixIcon: "assets/icons/league.svg",
                          onPress: () {
                            context.read<AppController>().awayTeamData = {
                              'name': controller.awayTeams[index].name,
                              'id': controller.awayTeams[index].id
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
    );
  }
}
