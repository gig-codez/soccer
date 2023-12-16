import 'dart:async';

import 'package:intl/intl.dart';
import '../../../widgets/no_data.dart';
import '/services/match_date_service.dart';

import '/exports/exports.dart';
import '/models/match_date.dart';
import 'add_match_date.dart';

class MatchDates extends StatefulWidget {
  final String leagueId;
  const MatchDates({super.key, required this.leagueId});

  @override
  State<MatchDates> createState() => _MatchDatesState();
}

class _MatchDatesState extends State<MatchDates> {
  final StreamController<List<MatchDateModel>> _matchDateController =
      StreamController<List<MatchDateModel>>();
  Timer? _timer;

  void fetchMatchDates() async {
    var matchdates = await MatchDateService.getMatchDates(widget.leagueId);
    _matchDateController.add(matchdates);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var matchdates = await MatchDateService.getMatchDates(widget.leagueId);
      _matchDateController.add(matchdates);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMatchDates();
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
                              onLongPress: () {
                                String m = DateFormat("EEE d MMM").format(
                                  DateTime.parse(matchs[index].date),
                                );
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog.adaptive(
                                          title:
                                              const Text("Delete match date!!"),
                                          content: Text(
                                              "Are you sure you want to delete $m?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Routes.popPage(),
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                MatchDateService
                                                    .deleteMatchDate(
                                                        matchs[index].id);
                                              },
                                              child: const Text("Delete"),
                                            )
                                          ]);
                                    });
                              },
                              titleText: DateFormat("EEE d MMM").format(
                                DateTime.parse(matchs[index].date),
                              ),
                              prefixIcon: "assets/month.svg",
                              color: Colors.green,
                              iconSize: 30,
                              size: 30,
                            );
                          },
                        )
                      : NoData()
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalSheet(AddMatchDate(
            leagueId: widget.leagueId,
          ));
        },
        label: const Text("Add a Date"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
