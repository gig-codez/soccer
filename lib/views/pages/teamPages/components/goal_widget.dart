import '../../../../services/player_service.dart';
import '/exports/exports.dart';

class GoalWidget extends StatefulWidget {
  final String playerId;
  final String leagueId;
  const GoalWidget({super.key, required this.playerId, required this.leagueId});

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  final goalTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          controller: goalTextController,
          titleText: "Attach a goal",
        ),
        CustomButton(
          onPress: () {
            PlayerService.attachGoalToPlayer(widget.playerId, widget.leagueId, {
              "goal": goalTextController.text,
            });
          },
          text: "Save Changes",
        )
      ],
    );
  }
}
