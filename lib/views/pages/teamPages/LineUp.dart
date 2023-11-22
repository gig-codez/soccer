import 'package:soccer/services/player_service.dart';

import '../../../exports/exports.dart';
import 'player_options.dart';

class LineUpPage extends StatefulWidget {
  final String homeTeamId;
  final String awayTeamId;
  const LineUpPage(
      {super.key, required this.homeTeamId, required this.awayTeamId});

  @override
  State<LineUpPage> createState() => _LineUpPageState();
}

class _LineUpPageState extends State<LineUpPage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: "Home Team",
                  ),
                  Tab(
                    text: "Away Team",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    PlayerWidget(id: widget.homeTeamId),
                    PlayerWidget(id: widget.awayTeamId),
                  ],
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
        //   child: Text(
        //     "Bench",
        //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //           fontWeight: FontWeight.bold,
        //         ),
        //   ),
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height / 2.7,
        //   child: ListView.builder(
        //     itemCount: 10,
        //     itemBuilder: (context, index) => ProfileWidget(
        //       titleText: "Player ${index + 1}",
        //       prefixIcon: "assets/icons/match.svg",
        //       color: Colors.amber,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String id;
  const PlayerWidget({super.key, required this.id});

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
