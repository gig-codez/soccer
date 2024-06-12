import '/controllers/table_controller.dart';

import 'edit_table.dart';

// import '/models/table_model.dart';
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
  // final StreamController<List<Message>> _streamController =
  //     StreamController<List<Message>>();
  // Timer? _timer;
  // void fetchData() async {
  //   var tableData = await TableService().getTeams(widget.leagueId);
  //   _streamController.add(tableData);
  //   Timer.periodic(const Duration(seconds: 1), (timer) async {
  //     var tableData = await TableService().getTeams(widget.leagueId);
  //     _streamController.add(tableData);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<TableController>(context, listen: false).dispose();
    // fetchData(
  }

  @override
  void dispose() {
    // if (_streamController.hasListener) {
    //   _streamController.close();
    // }
    // _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table Results"),
        actions: [
          IconButton(
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text("Reset Data"),
                  content: const Text("Do you want to refresh the data?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Routes.popPage();
                        TableService().resetTableData(widget.leagueId);
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Consumer<TableController>(
          builder: (context, tableController, sna) {
            tableController.fetchData(widget.leagueId);
            return tableController.loading == false
                ? tableController.tableData.isEmpty
                    ? const Center(
                        child: Text("No data found"),
                      )
                    : ListView.builder(
                        itemCount: tableController.tableData.length,
                        itemBuilder: (context, index) {
                          var data = tableController.tableData[index];
                          return ProfileWidget(
                            img: data.team.image,
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
