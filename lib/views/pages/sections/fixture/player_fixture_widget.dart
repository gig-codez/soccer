import '../../../../models/player.dart';
import '../../../../services/player_service.dart';
import '../../teamPages/player_options.dart';
import '/exports/exports.dart';

class PlayerFixtureWidget extends StatefulWidget {
  final String id;
  final Widget? trailing;
  final String leagueId;
  const PlayerFixtureWidget(
      {super.key, required this.id, this.trailing, required this.leagueId});

  @override
  State<PlayerFixtureWidget> createState() => _PlayerFixtureWidgetState();
}

class _PlayerFixtureWidgetState extends State<PlayerFixtureWidget> {
  List<Message> players = [];
  @override
  void initState() {
    super.initState();
    PlayerService().getPlayers(widget.id).then((value) {
      setState(() {
        players = value;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return players.isNotEmpty
        ? ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) => ProfileWidget(
              iconSize: 30,
              titleText: players[index].name,
              subText: players[index].position,
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
                              leagueId: widget.leagueId,
                              data: players[index],
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
  }
}
