import '/controllers/team_controller.dart';
import '/exports/exports.dart';

class ShowLeagues extends StatefulWidget {
  final String leagueId;
  final ValueChanged<Map<String, dynamic>> valueChanged;
  const ShowLeagues(
      {super.key, required this.leagueId, required this.valueChanged});

  @override
  State<ShowLeagues> createState() => _ShowLeaguesState();
}

class _ShowLeaguesState extends State<ShowLeagues> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Consumer<TeamController>(
        builder: (context, controller, snap) {
          if (mounted) {
            controller.getTeams(widget.leagueId);
          }
          return controller.loading == false
              ? controller.teams.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.teams.length,
                      itemBuilder: (context, index) {
                        return ProfileWidget(
                          // ignore: unnecessary_string_interpolations
                          titleText: "${controller.teams[index].name}",
                          prefixIcon: "assets/icons/league.svg",
                          onPress: () {
                            widget.valueChanged({
                              'name': controller.teams[index].name,
                              'id': controller.teams[index].id
                            });
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
