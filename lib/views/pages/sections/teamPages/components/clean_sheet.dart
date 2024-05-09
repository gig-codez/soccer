import '../../../../../services/player_service.dart';
import '/exports/exports.dart';

class CleanSheetWidget extends StatefulWidget {
  final String playerId;
  final String leagueId;
  const CleanSheetWidget(
      {super.key, required this.playerId, required this.leagueId});

  @override
  State<CleanSheetWidget> createState() => _CleanSheetWidgetState();
}

class _CleanSheetWidgetState extends State<CleanSheetWidget> {
  final cleanSheetTextController = TextEditingController();
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
                  "Clean Sheet",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              CommonTextField(
                padding: const EdgeInsets.fromLTRB(10, 13, 10, 12),
                controller: cleanSheetTextController,
                icon: Icons.sports_soccer,
                titleText: "Attach clean sheet",
                readOnly: controller.isLoading,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomButton(
                  loading: controller.isLoading,
                  onPress: controller.isLoading
                      ? () {}
                      : () {
                          PlayerService.attachCleanSheetToPlayer(
                              widget.playerId, widget.leagueId, {
                            "clean_sheet": cleanSheetTextController.text,
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
