import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import '/models/team.dart';

import '/exports/exports.dart';
import '/services/team_service.dart';

class UpdateTeam extends StatefulWidget {
  final String leagueId;
  final Message team;
  const UpdateTeam({super.key, required this.leagueId, required this.team});

  @override
  State<UpdateTeam> createState() => _UpdateTeamState();
}

class _UpdateTeamState extends State<UpdateTeam>
    with SingleTickerProviderStateMixin {
  final teamNameController = TextEditingController();

  Uint8List? imageData;
  String fileName = "";
  String? currentImage;
  Stream<Uint8List>? streamData;
  @override
  void initState() {
    super.initState();

    teamNameController.text = widget.team.name;
    currentImage = widget.team.image;
    debugPrint(currentImage);
  }

  int fileLength = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
        child: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: streamData != null
                          ? Image.memory(imageData!,
                              width: 80, height: 80, fit: BoxFit.cover)
                          : Image.network(
                              Apis.image + currentImage!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox.square(
                      dimension: 30,
                    ),
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
                    TeamService.updateTeam({
                      "name": teamNameController.text,
                      "league": widget.leagueId,
                      "stream": streamData,
                      "length": fileLength,
                      "filename": fileName
                    }, widget.team.id);
                  }
                },
                text: "Save Details",
              ),
              const SizedBox.square(
                dimension: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
