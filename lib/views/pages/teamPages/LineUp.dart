import '../../../exports/exports.dart';
import 'player_options.dart';

class LineUpPage extends StatefulWidget {
  const LineUpPage({super.key});

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
          height: MediaQuery.of(context).size.height / 2,
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
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => ProfileWidget(
                        titleText: "Player ${index + 1}",
                        prefixIcon: "assets/icons/match.svg",
                        onPress: () {
                          showModalBottomSheet(
                              showDragHandle: true,
                              context: context,
                              builder: (context) {
                                return BottomSheet(
                                    onClosing: () {},
                                    builder: (context) {
                                      return const PlayerOptions();
                                    });
                              });
                        },
                        color: Colors.amber,
                      ),
                    ),
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => ProfileWidget(
                        titleText: "Player ${index + 1}",
                        prefixIcon: "assets/icons/match.svg",
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
          child: Text(
            "Bench",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.7,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ProfileWidget(
              titleText: "Player ${index + 1}",
              prefixIcon: "assets/icons/match.svg",
              color: Colors.amber,
            ),
          ),
        ),
      ],
    );
  }
}
