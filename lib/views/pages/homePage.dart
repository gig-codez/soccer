import 'dart:async';

import 'package:intl/intl.dart';
import 'package:soccer/services/match_date_service.dart';

import '../../models/match_date.dart';

import '/widgets/DrawerWidget.dart';

import '/exports/exports.dart';
import 'sections/Teams.dart';
import 'sections/leagues.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final StreamController<List<MatchDateModel>> _matchDateController =
      StreamController<List<MatchDateModel>>();
  Timer? _timer;

  void fetchMatchDates() async {
    var matchdates = await MatchDateService.getMatchDates("");
    _matchDateController.add(matchdates);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var matchdates = await MatchDateService.getMatchDates("");
      _matchDateController.add(matchdates);
    });
  }

  TabController? tabController;
  int tabs = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_matchDateController.hasListener) {
      _matchDateController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  List<DateTime> _getDaysBetweenDates(DateTime startDate, DateTime endDate) {
    List<DateTime> dates = [];

    DateTime currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dates;
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
    var dates = _getDaysBetweenDates(DateTime(2022), DateTime(2023));
    return Scaffold(
      appBar: AppBar(
        // leading: const SizedBox(),
        title: const Text('Samba Stats'),
      ),
      drawer: const DrawerWidget(),
      body: const Leagues(),
      // DefaultTabController(
      //   length: dates.length,

      //   child: Column(
      //     children: [
      //       TabBar(
      //         isScrollable: true,
      //         tabs: List.generate(
      //           dates.length,
      //           (index) => Tab(
      //             child: Text(_getTabLabel(
      //               dates[index],
      //             )),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         child: TabBarView(
      //           children: List.generate(
      //             dates.length,
      //             (index) => Padding(
      //               padding: const EdgeInsets.only(left: 10.0, right: 10),
      //               child: Text("Page $index"),
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
