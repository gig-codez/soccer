import '../../../../controllers/data_controller.dart';
import '../../../../services/player_service.dart';
import '/exports/exports.dart';

class AddAssist extends StatefulWidget {
  final String playerId;
  final String leagueId;
  final String teamId;
  const AddAssist(
      {super.key,
      required this.playerId,
      required this.leagueId,
      required this.teamId});

  @override
  State<AddAssist> createState() => _AddAssistState();
}

class _AddAssistState extends State<AddAssist> {
  final assistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderController>(builder: (context, controller, child) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.24,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              CommonTextField(
                padding: const EdgeInsets.all(18.0),
                controller: assistController,
                titleText: "Attach an assist",
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomButton(
                  loading: controller.isLoading,
                  onPress: () {
                    PlayerService.attachAssistToPlayer(
                        widget.playerId, widget.leagueId, {
                      "assist": assistController.text,
                    });
                  },
                  text: "Save Changes",
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class ShowPlayers extends StatelessWidget {
  final String teamId;
  const ShowPlayers({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (context, controller, child) {
      controller.fetchPlayers(teamId);
      return controller.players.isNotEmpty
          ? ListView.builder(
              itemCount: controller.players.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(controller.players[i].name),
                  onTap: () {
                    controller.playerData = {
                      "id": controller.players[i].id,
                      "name": controller.players[i].name,
                    };
                    Routes.popPage();
                  },
                );
              },
            )
          : const Center(
              child: Text("No players found"),
            );
    });
  }
}
