import '../../../services/league_service.dart';
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
        child: FutureBuilder(
          future: LeagueService().getLeague(),
          builder: (context, snap) {
            return snap.hasData
                ? snap.data != null && snap.data!.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return ProfileWidget(
                            titleText: "${snap.data?[index].name}",
                            prefixIcon: "assets/icons/league.svg",
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
