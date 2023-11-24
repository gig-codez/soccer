import 'dart:async';

import 'package:intl/intl.dart';
import 'package:soccer/services/match_date_service.dart';

import '/exports/exports.dart';
import '/models/match_date.dart';
import 'add_match_date.dart';

class MatchDates extends StatefulWidget {
  const MatchDates({super.key});

  @override
  State<MatchDates> createState() => _MatchDatesState();
}

class _MatchDatesState extends State<MatchDates> {
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

  @override
  void initState() {
    super.initState();
    fetehMatchDates();
  }

  @override
  void dispose() {
    if (_matchDateController.hasListener) {
      _matchDateController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Dates'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: StreamBuilder(
            stream: _matchDateController.stream,
            builder: (context, snapshot) {
              var matchs = snapshot.data;
              return snapshot.hasData
                  ? matchs!.isNotEmpty
                      ? ListView.builder(
                          itemCount: matchs.length,
                          itemBuilder: (context, index) {
                            return ProfileWidget(
                              titleText: DateFormat("EEE d MMM").format(
                                DateTime.parse(matchs[index].date),
                              ),
                              prefixIcon: "assets/football.svg",
                              color: Colors.green,
                              iconSize: 30,
                              size: 30,
                            );
                          },
                        )
                      : const Center(
                          child: Text("No match dates found"),
                        )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (context) {
                return BottomSheet(
                    onClosing: () {},
                    builder: (context) {
                      return const AddMatchDate();
                    });
              });
        },
        label: const Text("Add a Date"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
