import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '../../../exports/exports.dart';
import '../../../services/team_service.dart';
import '../../../tools/tools.dart';

class AddTeam extends StatefulWidget {
  final String? leagueId;
  const AddTeam({super.key, this.leagueId});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  final teamNameController = TextEditingController();
  Uint8List? imageData;
  String fileName = "";
  Stream<Uint8List>? streamData;
  int fileLength = 0;
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
                  "Add Team Information",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    streamData == null
                        ? Image.asset("assets/leagues/amigos.jpeg",
                            width: 80, height: 80)
                        : Image.memory(imageData!,
                            width: 80, height: 80, fit: BoxFit.cover),
                    IconButton(
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 50,
                      ),
                      onPressed: () {
                        ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((file) {
                          setState(() {
                            imageData = File(file!.path).readAsBytesSync();
                            fileName = file.path.split("/").last;
                            streamData =
                                File(file.path).readAsBytes().asStream();
                            fileLength = File(file.path).lengthSync();
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              CommonTextField(
                titleText: "Team Name",
                hintText: "Enter team name",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                controller: teamNameController,
              ),
              CustomButton(
                onPress: () {
                  if (teamNameController.text.isEmpty) {
                    showMessage(
                      msg: "Please fill all the fields",
                    );
                  } else {
                    TeamService.createTeam({
                      "name": teamNameController.text,
                      "league": widget.leagueId,
                      "stream": streamData,
                      "length": fileLength,
                      "filename":fileName
                    });
                  }
                },
                text: "Save Details",
              )
            ],
          ),
        ),
      ),
    );
  }
}
