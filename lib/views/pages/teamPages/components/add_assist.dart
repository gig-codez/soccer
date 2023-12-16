import '../../../../services/player_service.dart';
import '/exports/exports.dart';

class AddAssist extends StatelessWidget {
  final String playerId;
  final String leagueId;
  const AddAssist({super.key, required this.playerId, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CommonTextField(
          titleText: "Attach an assist",
        ),
        CustomButton(
          onPress: () {
            PlayerService.attachAssistToPlayer(playerId, leagueId, {
              "assist": 1,
            });
          },
          text: "Save Changes",
        )
      ],
    );
  }
}
