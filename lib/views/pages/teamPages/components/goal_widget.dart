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
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CommonTextField(
              padding: const EdgeInsets.all(18.0),
            controller: goalTextController,
            titleText: "Attach a goal",
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomButton(
              onPress: () {
                PlayerService.attachGoalToPlayer(widget.playerId, widget.leagueId, {
                  "goal": goalTextController.text,
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
