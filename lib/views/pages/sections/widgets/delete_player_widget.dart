import '/exports/exports.dart';

class DeletePlayerWidget extends StatefulWidget {
  final String playerId;
  final String playerName;
  const DeletePlayerWidget(
      {super.key, required this.playerId, required this.playerName});

  State<DeletePlayerWidget> createState() => _DeletePlayerWidgetState();
}

class _DeletePlayerWidgetState extends State<DeletePlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
