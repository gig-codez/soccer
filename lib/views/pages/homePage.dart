import 'dart:async';

import 'package:intl/intl.dart';
import 'package:soccer/services/match_date_service.dart';

import '../../models/match_date.dart';
import '../../widgets/LeagueWidget.dart';
import '/services/league_service.dart';
import '/widgets/DrawerWidget.dart';

import '/exports/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final StreamController<List<MatchDateModel>> _matchDateController =
      StreamController<List<MatchDateModel>>();
  Timer? _timer;

  void fetehMatchDates() async {
    var matchdates = await MatchDateService.getMatchDates();
    _matchDateController.add(matchdates);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var matchdates = await MatchDateService.getMatchDates();
      _matchDateController.add(matchdates);
    });
  }

  TabController? tabController;
  int tabs = 0;
  @override
  void initState() {
    super.initState();
    fetehMatchDates();
    MatchDateService.getMatchDates().then((x) {
      tabController = TabController(length: x.length, vsync: this);
    });
  }

  @override
  void dispose() {
    if (_matchDateController.hasListener) {
      _matchDateController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  String _getTabLabel(DateTime date) {
    String stringDate = DateFormat('EEE d MMM').format(date);
    String currentDate = DateFormat('EEE d MMM').format(DateTime.now());
    // Customize the logic to determine the label based on the relation to the current date
    if (stringDate.split(" ").first == currentDate.split(" ").first &&
        stringDate.split(" ")[1] == currentDate.split(" ")[1]) {
      return 'Today';
    } else if (int.parse(stringDate.split(" ")[1]) ==
        (int.parse(currentDate.split(" ")[1]) - 1)) {
      return 'Yesterday';
    } else if (int.parse(stringDate.split(" ")[1]) ==
        (int.parse(currentDate.split(" ")[1]) + 1)) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE d MMM').format(date);
    }
  }

  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Samba Stats'),
        ),
        drawer: const DrawerWidget(),
        body: StreamBuilder(
          stream: _matchDateController.stream,
          builder: (context, snapshot) {
            var mDates = snapshot.data;
            int x = 0;
            if (mDates != null) {
              if (mounted && x == 0) {
                x += 1;
              }
            }

            return snapshot.hasData
                ? mDates != null && mDates.isNotEmpty
                    ? Column(
                        children: [
                          TabBar(
                            controller: tabController,
                            // onTap: (index) {
                            //   setState(() {
                            //     currentTab = index;
                            //   });
                            // },
                            isScrollable: true,
                            tabs: List.generate(
                              mDates.length,
                              (index) => Tab(
                                text: _getTabLabel(
                                  DateTime.parse(mDates[index].date),
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              width: MediaQuery.of(context).size.width,
                              child: TabBarView(
                                controller: tabController,
                                children: List.generate(
                                  mDates.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: FutureBuilder(
                                      future: LeagueService().getLeague(),
                                      builder: (context, snap) {
                                        var d = snap.data;
                                        return snap.hasData
                                            ? d != null && d.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: d.length,
                                                    itemBuilder:
                                                        (context, leagueData) {
                                                      return LeagueWidget(
                                                        data: d[leagueData],
                                                        matchId: mDates[
                                                                tabController!
                                                                    .index]
                                                            .id,
                                                      );
                                                    })
                                                : const Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "No fixture yet set for today!"),
                                                        // OutlinedButton.icon(onPressed: (){}, icon: icon, label: Text("Add "))
                                                      ],
                                                    ),
                                                  )
                                            : const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : const Center(
                        child: Text(
                        "No fixture dates yet set !",
                      ))
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator.adaptive(),
                        Text("Loading data")
                      ],
                    ),
                  );
          },
        ));
  }
}
