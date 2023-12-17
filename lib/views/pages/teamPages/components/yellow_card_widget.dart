import '../../../../services/player_service.dart';
import '/exports/exports.dart';

class YellowCardWidget extends StatefulWidget {
  final String playerId;
  final String leagueId;
  const YellowCardWidget(
      {super.key, required this.playerId, required this.leagueId});

  @override
  State<YellowCardWidget> createState() => _YellowCardWidgetState();
}

class _YellowCardWidgetState extends State<YellowCardWidget> {
  final yellowCardTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CommonTextField(
            padding: const EdgeInsets.all(18.0),
            titleText: "Attach a yellow",
            controller: yellowCardTextController,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomButton(
              onPress: () {
                PlayerService.attachYellowCardToPlayer(
                  widget.playerId,
                  widget.leagueId,
                  {
                    "yellow_card": yellowCardTextController.text,
                  },
                );
              },
              text: "Save Changes",
            ),
          )
        ],
      ),
    );
  }
}
