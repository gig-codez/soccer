import '/controllers/data_controller.dart';
import '../../teamPages/player_options.dart';
import '/exports/exports.dart';

class PlayerFixtureWidget extends StatelessWidget {
  final String id;
  final Widget? trailing;
  final String leagueId;
  const PlayerFixtureWidget(
      {super.key, required this.id, this.trailing, required this.leagueId});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (c, controller, homeSnap) {
      controller.fetchPlayers(id);
      return controller.players.isNotEmpty
          ? ListView.builder(
              itemCount: controller.players.length,
              itemBuilder: (context, index) => ProfileWidget(
                iconSize: 30,
                titleText: controller.players[index].name,
                subText: controller.players[index].position,
                prefixIcon: "assets/icons/match.svg",
                trailing: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        builder: (context) {
                          return BottomSheet(
                            onClosing: () {},
                            builder: (context) {
                              return PlayerOptions(
                                leagueId: leagueId,
                                data: controller.players[index],
                              );
                            },
                          );
                        });
                  },
                  icon: const Icon(Icons.edit),
                ),
                color: Colors.amber,
              ),
            )
          : const Center(
              child: Text("No Players added yet"),
            );
    });
  }
}
