import '../../../../../services/player_service.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Consumer<LoaderController>(builder: (context, controller, c) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Goal",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              CommonTextField(
                padding: const EdgeInsets.fromLTRB(10, 13, 10, 12),
                controller: goalTextController,
                icon: Icons.sports_soccer,
                titleText: "Attach a goal",
                readOnly: controller.isLoading,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomButton(
                  loading: controller.isLoading,
                  onPress: controller.isLoading
                      ? () {}
                      : () {
                          PlayerService.attachGoalToPlayer(
                              widget.playerId, widget.leagueId, {
                            "goal": goalTextController.text,
                          });
                        },
                  text: "Save Changes",
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
