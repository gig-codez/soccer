import '/views/pages/sections/Fixtures.dart';
import '../../../../exports/exports.dart';
import '../../table_data/TableResults.dart';
import '../add_team.dart';
import '../match_dates.dart';

class LeagueOptions extends StatelessWidget {
  final String leagueId;
  final String leagueName;
  const LeagueOptions(
      {super.key, required this.leagueId, required this.leagueName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.43,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Text("$leagueName's Options",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(fontSizeDelta: 2)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(
                "Add a team",
              ),
              onTap: () {
                Routes.popPage();
                showModalSheet(
                  AddTeam(leagueId: leagueId),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text(
                "Match dates",
              ),
              onTap: () {
                Routes.popPage();
                Routes.animateToPage(
                  MatchDates(
                    leagueId: leagueId,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_football),
              title: const Text(
                "Fixtures",
              ),
              onTap: () {
                Routes.popPage();
                Routes.animateToPage(
                  FixturesPage(
                    leagueId: leagueId,
                    leagueName: leagueName,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup_table),
              title: const Text(
                "Table results",
              ),
              onTap: () {
                Routes.popPage();
                Routes.animateToPage(
                  TableResults(
                    leagueId: leagueId,
                    // leagueName: snap.data![index].name,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
