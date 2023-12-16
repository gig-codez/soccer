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
    return Column(
      children: [
        CommonTextField(
          titleText: "Attach a yellow",
          controller: yellowCardTextController,
        ),
        CustomButton(
          onPress: () {
            PlayerService.attachYellowCardToPlayer(
              widget.playerId,
              widget.leagueId,
              {
                "red": yellowCardTextController.text,
              },
            );
          },
          text: "Save Changes",
        )
      ],
    );
  }
}
