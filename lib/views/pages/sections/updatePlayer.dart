import '/exports/exports.dart';
import '/services/player_service.dart';

class UpdatePlayer extends StatefulWidget {
  final String? name;
  final String? position;
  final String? id;
  final String? teamId;
  UpdatePlayer({super.key, this.name, this.position, this.id, this.teamId});

  @override
  State<UpdatePlayer> createState() => _UpdatePlayerState();
}

class _UpdatePlayerState extends State<UpdatePlayer> {
  final playerNameController = TextEditingController();

  final playerPositionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 13),
                child: Text(
                  "Provide Player's information",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              CommonTextField(
                controller: playerNameController,
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                titleText: "Name : ${widget.name}",
                icon: Icons.person,
                hintText: "e.g John Gum",
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                enableBorder: true,
              ),
              CommonTextField(
                controller: playerPositionController,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                titleText: "Position: ${widget.position}",
                hintText: "e.g Defender",
                icon: Icons.roller_shades,
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                enableBorder: true,
              ),
              CustomButton(
                onPress: () {
                  if (playerNameController.text.isEmpty ||
                      playerPositionController.text.isEmpty) {
                    showMessage(
                      msg: "Please fill all the fields",
                      color: Colors.red,
                    );
                  } else {
                    PlayerService.updatePlayer(widget.id ?? "", {
                      "name": playerNameController.text,
                      "team": widget.teamId,
                      "position": playerPositionController.text
                    });
                  }
                },
                text: "Save Player details",
              )
            ],
          ),
        ),
      ),
    );
  }
}
