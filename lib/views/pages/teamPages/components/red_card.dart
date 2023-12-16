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
    return Column(
      children: [
        CommonTextField(
          titleText: "Attach a red",
          controller: redTextController,
        ),
        CustomButton(
          onPress: () {
            PlayerService.attachRedCardToPlayer(
                widget.playerId, widget.leagueId, {
              "red": redTextController.text,
            });
          },
          text: "Save Changes",
        )
      ],
    );
  }
}
