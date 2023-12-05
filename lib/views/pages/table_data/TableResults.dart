import 'dart:async';

import 'package:soccer/views/pages/table_data/edit_table.dart';

import '/models/table_model.dart';
import '/services/table_service.dart';
import '/exports/exports.dart';

class TableResults extends StatefulWidget {
  final String leagueId;
  const TableResults({
    super.key,
    required this.leagueId,
  });

  @override
  State<TableResults> createState() => _TableResultsState();
}

class _TableResultsState extends State<TableResults> {
  StreamController<List<Message>> _streamController =
      StreamController<List<Message>>();
  Timer? _timer;
  void fetchData() async {
    var tableData = await TableService().getTeams(widget.leagueId);
    _streamController.add(tableData);
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      var tableData = await TableService().getTeams(widget.leagueId);
      _streamController.add(tableData);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    if (_streamController.hasListener) {
      _streamController.close();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Results"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data!.isEmpty
                    ? const Center(
                        child: Text("No data found"),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data![index];
                          return ProfileWidget(
                            img: Apis.image + data.team.image,
                            titleText: data.team.name,
                            onPress: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                builder: (context) => BottomSheet(
                                  onClosing: () {},
                                  builder: (context) => EditTable(data: data),
                                ),
                              );
                            },
                          );
                        },
                      )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
          },
        ),
      ),
    );
  }
}
