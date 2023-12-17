import '../../../../services/player_service.dart';
import '/exports/exports.dart';

class RedCard extends StatefulWidget {
  final String playerId;
  final String leagueId;
  const RedCard({super.key, required this.playerId, required this.leagueId});

  @override
  State<RedCard> createState() => _RedCardState();
}

class _RedCardState extends State<RedCard> {
  final redTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CommonTextField(
            padding: const EdgeInsets.all(18.0),
            titleText: "Attach a red",
            controller: redTextController,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomButton(
              onPress: () {
                PlayerService.attachRedCardToPlayer(
                    widget.playerId, widget.leagueId, {
                  "red_card": redTextController.text,
                });
              },
              text: "Save Changes",
            ),
          )
        ],
      ),
    );
  }
}
