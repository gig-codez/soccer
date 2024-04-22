import '/controllers/team_controller.dart';

import '/exports/exports.dart';
// import 'transfer_widget.dart';

class ShowTransferTeams extends StatefulWidget {
  final String teamId;
  const ShowTransferTeams({super.key, required this.teamId});

  @override
  State<ShowTransferTeams> createState() => _ShowTransferTeamsState();
}

class _ShowTransferTeamsState extends State<ShowTransferTeams> {
  @override
  void initState() {
    super.initState();
    Provider.of<TeamController>(context, listen: false).getTeams(widget.teamId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<TeamController>(builder: (context, controller, child) {
        controller.getTeams(widget.teamId);
        // controller.teams.sort((a, b) => a.name.compareTo(b.name));
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select team",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 7, 10, 0),
                child: Divider(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.teams.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Text("T"),
                      ),
                      title: Text(controller.teams[index].name),
                      // subtitle: Text(controller.teams[index].league),
                      onTap: () {
                        controller.selectedTeam = {
                          "name": controller.teams[index].name,
                          "id": controller.teams[index].id,
                        };
                        Routes.popPage();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
