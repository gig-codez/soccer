import 'package:soccer/services/player_service.dart';

import '../../../../exports/exports.dart';

class CastMessage extends StatefulWidget {
  final String leagueId;
  const CastMessage({super.key, required this.leagueId});

  @override
  State<CastMessage> createState() => _CastMessageState();
}

class _CastMessageState extends State<CastMessage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            CommonTextField(
              titleText: "Message Title",
              hintText: "title....",
              controller: titleController,
              padding: const EdgeInsets.all(18.0),
            ),
            CommonTextField(
              titleText: "Message Body",
              hintText: "body....",
              controller: bodyController,
              padding: const EdgeInsets.all(18.0),
            ),
            CustomButton(
              text: "Send Message",
              onPress: () {
                if (titleController.text.isNotEmpty &&
                    bodyController.text.isNotEmpty) {
                  // send message
                  PlayerService.castMessage({
                    "title": titleController.text,
                    "body": bodyController.text,
                    "league": widget.leagueId
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
