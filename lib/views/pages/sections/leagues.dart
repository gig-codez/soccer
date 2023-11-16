import '/exports/exports.dart';
import 'add_league.dart';

class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leagues"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ProfileWidget(
              tile: true,
              titleText: "English Premier League",
              color: Colors.red,
              subText: "20 teams",
              prefixIcon: "assets/icons/league.svg",
              onPress: () {
                Routes.pushPage(context, Routes.teams);
              },
            )
          ],
        ),
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
                      return const AddLeague();
                    });
              });
        },
        label: Text(
          "Add league",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
