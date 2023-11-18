import 'package:soccer/widgets/FixtureWidget.dart';

import '../../../services/fixture_service.dart';
import '/views/pages/sections/add_fixture.dart';
import '/views/pages/sections/show_leagues.dart';

import '../../../exports/exports.dart';

class FixturesPage extends StatefulWidget {
  final String leagueId;
  final String leagueName;
  const FixturesPage(
      {super.key, required this.leagueId, required this.leagueName});

  @override
  State<FixturesPage> createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 500),
    );
  }

  void fetchCurrentData() async {}
  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.leagueName}\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Fixtures",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: FixtureService.getFixtures(widget.leagueId),
        builder: (context, snap) {
          return snap.hasData
              ? snap.data != null && snap.data!.isNotEmpty
                  ? ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) => FixtureWidget(
                        homeTeam: snap.data![index].hometeam.name,
                        awayTeam: snap.data![index].awayteam.name,
                        homeTeamLogo: snap.data![index].hometeam.image,
                        awayTeamLogo: snap.data![index].awayteam.image,
                        onTap: () {},
                      ),
                    )
                  : Center(
                      child: Text("No fixtures found",
                          style: Theme.of(context).textTheme.titleLarge),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            transitionAnimationController: _controller,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return AddFixture(
                      leagueId: widget.leagueId,
                    );
                  });
            }),
        label: Text(
          "Add a fixture",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
