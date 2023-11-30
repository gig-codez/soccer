import '../../teamPages/player_options.dart';
import '/exports/exports.dart';
import '/services/player_service.dart';

class PlayerFixtureWidget extends StatelessWidget {
  final String id;
  final Widget? trailing;
  const PlayerFixtureWidget({super.key, required this.id, this.trailing});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PlayerService().getPlayers(id),
        builder: (c, homeSnap) {
          return homeSnap.hasData
              ? homeSnap.data != null && homeSnap.data!.isNotEmpty
                  ? ListView.builder(
                      itemCount: homeSnap.data!.length,
                      itemBuilder: (context, index) => ProfileWidget(
                        iconSize: 30,
                        titleText: homeSnap.data![index].name,
                        subText: homeSnap.data![index].position,
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
                                        data: homeSnap.data![index],
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
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        });
  }
}
