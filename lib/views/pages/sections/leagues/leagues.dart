import '/controllers/league_controller.dart';
import '/exports/exports.dart';
import '/views/pages/sections/teams/Teams.dart';
import 'add_league.dart';

class Leagues extends StatefulWidget {
  const Leagues({super.key});

  @override
  State<Leagues> createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 8, 13, 0),
          child: Consumer<LeagueController>(
            builder: (context, controller, s) {
              if (mounted) {
                controller.fetchLeagues();
              }
              return controller.loading == false
                  ? controller.leagues.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.leagues.length,
                          itemBuilder: (context, index) {
                            return ProfileWidget(
                              titleText:
                                  controller.leagues[index].name.toUpperCase(),
                              // img: controller.leagues[index].image,
                              prefixIcon: "assets/icons/league.svg",
                              iconSize: 20,
                              color: Theme.of(context).primaryColor,
                              onPress: () {
                                Routes.animateToPage(
                                  Teams(
                                    leagueId: controller.leagues[index].id,
                                    leagueName: controller.leagues[index].name,
                                  ),
                                );
                              },
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalSheet(const AddLeague());
        },
        label: Text(
          "Add League",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
