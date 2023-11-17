import 'package:soccer/services/league_service.dart';

import '../../../exports/exports.dart';

class ShowLeagues extends StatefulWidget {
  const ShowLeagues({super.key});

  @override
  State<ShowLeagues> createState() => _ShowLeaguesState();
}

class _ShowLeaguesState extends State<ShowLeagues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
