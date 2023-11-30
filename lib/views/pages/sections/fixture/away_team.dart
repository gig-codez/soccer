import '../../teamPages/LineUp.dart';
import '/exports/exports.dart';

class AwayTeamFixture extends StatefulWidget {
  final String id;
  const AwayTeamFixture({super.key, required this.id});

  @override
  State<AwayTeamFixture> createState() => _AwayTeamFixtureState();
}

class _AwayTeamFixtureState extends State<AwayTeamFixture> {
  @override
  Widget build(BuildContext context) {
    return PlayerWidget(id: widget.id);
  }
}
