import '../../../../controllers/team_controller.dart';
import '../../../../exports/exports.dart';
import '../../../../services/player_service.dart';
import '../teams/show_transfer_teams.dart';

class TransferWidget extends StatefulWidget {
  final String teamId;
  final String leagueId;
  final String playerId;
  const TransferWidget(
      {super.key,
      required this.teamId,
      required this.playerId,
      required this.leagueId});

  @override
  State<TransferWidget> createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget> {
  final newTeamController = TextEditingController();
  final soldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Consumer<TeamController>(builder: (context, controller, child) {
          newTeamController.text = controller.selectedTeam["name"] ?? "";
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Transfer player",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 7, 10, 0),
                  child: Divider(),
                ),
                CommonTextField(
                  controller: newTeamController,
                  titleText: "New Team",
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  enableBorder: true,
                  hintText: "New team's name appears here...",
                  enableSuffix: true,
                  suffixIcon: Icons.add_card,
                  onTapSuffix: () {
                    showModalSheet(
                      ShowTransferTeams(
                        teamId: widget.leagueId,
                      ),
                    );
                  },
                  readOnly: true,
                ),
                CommonTextField(
                  controller: soldController,
                  titleText: "Sold",
                  hintText: "Enter sold",
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  enableBorder: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          textColor: Colors.white,
                          onPress: () => Routes.popPage(),
                          buttonColor: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                          text: "Transfer",
                          onPress: () {
                            PlayerService.transferPlayer({
                              "id": widget.playerId,
                              "league": widget.leagueId,
                              "team": controller.selectedTeam["id"],
                              "sold_out": soldController.text,
                            });
                            // clear selected data
                            controller.selectedTeam = {};
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
