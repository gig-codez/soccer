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
          child: ListView(
            children: [
              ProfileWidget(
                titleText: "Bruno Fc",
                prefixIcon: "assets/icons/match.svg",
                color: Colors.deepOrange,
                onPress: () {
                  Routes.pushPage(context, Routes.players);
                },
              ),
            ],
          ),
        ),
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
