import 'package:soccer/services/team_service.dart';
import 'package:soccer/views/pages/sections/add_team.dart';

import '../../../exports/exports.dart';

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "English Primier League\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Teams",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
            child: FutureBuilder(
              future: TeamService().getTeams(),
              builder: (context, snap) {
                return snap.hasData
                    ? snap.data != null && snap.data!.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return ProfileWidget(
                                titleText: "${snap.data?[index].name}",
                                prefixIcon: "assets/icons/match.svg",
                              );
                            },
                          )
                        : const Center(
                            child: Text("No league found"),
                          )
                    : const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return const AddTeam();
                  });
            }),
        label: const Text("Add a team"),
      ),
    );
  }
}
