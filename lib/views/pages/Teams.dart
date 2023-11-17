import 'package:soccer/views/pages/teamPages/LineUp.dart';

import '../../widgets/PlayingTeams.dart';
import '/exports/exports.dart';
import 'teamPages/stats_page.dart';
import 'teamPages/table_page.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> with TickerProviderStateMixin {
  TabController? _topTabController;

  @override
  void initState() {
    super.initState();
    _topTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _topTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              const PlayingTeams(),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      tabs: const [
                        Tab(
                          text: "Line Up",
                        ),
                        Tab(
                          text: "Table",
                        ),
                        Tab(
                          text: "Stats",
                        ),
                      ],
                      controller: _topTabController,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _topTabController,
                        children: const [
                          LineUpPage(),
                          TablePage(),
                          StatsPage()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
