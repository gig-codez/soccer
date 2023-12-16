import 'package:soccer/views/pages/teamPages/player_options.dart';

import '../../teamPages/LineUp.dart';
import '/exports/exports.dart';
import 'player_fixture_widget.dart';

class HomeTeamFixture extends StatefulWidget {
  final String id;
  final String leagueId;
  const HomeTeamFixture({super.key, required this.id, required this.leagueId});

  @override
  State<HomeTeamFixture> createState() => _HomeTeamFixtureState();
}

class _HomeTeamFixtureState extends State<HomeTeamFixture> {
  @override
  Widget build(BuildContext context) {
    return PlayerFixtureWidget(
      id: widget.id,
      leagueId: widget.leagueId,
    );
  }
}
