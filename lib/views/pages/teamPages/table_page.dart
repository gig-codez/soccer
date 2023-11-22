import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import '../../../models/team.dart';
import '../../../services/team_service.dart';
import '/views/pages/teamPages/table_row_widget.dart';

import '/exports/exports.dart';

class TablePage extends StatefulWidget {
  final String leagueId;
  const TablePage({super.key, required this.leagueId});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final StreamController<List<Message>> _leaguesController =
      StreamController<List<Message>>();
  Timer? _timer;
  void fetchLeagues() async {
    var leagues = await TeamService().getTeams(widget.leagueId);
    _leaguesController.add(leagues);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      var leagues = await TeamService().getTeams(widget.leagueId);
      _leaguesController.add(leagues);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLeagues();
  }

  @override
  void dispose() {
    if (_leaguesController.hasListener) {
      _leaguesController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _leaguesController.stream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.data != null && snapshot.data!.isNotEmpty
                  ? Card(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      elevation: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn2(label: Text("#")),
                              DataColumn2(label: Text("P")),
                              DataColumn2(label: Text("W")),
                              DataColumn2(label: Text("D")),
                              DataColumn2(label: Text("L")),
                              DataColumn2(label: Text("GD")),
                              DataColumn2(label: Text("Pts")),
                            ],
                            rows: List.generate(
                              snapshot.data!.length,
                              (index) => TableRowWidget.drawDatRow(
                                context,
                                color: index % 2 == 0
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade50,
                                id: index + 1,
                                image: snapshot.data![index].image,
                                p: 0,
                                w: 0,
                                d: 0,
                                l: 0,
                                gd: 0,
                                pts: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("No Teams added yet"),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        });
  }
}
