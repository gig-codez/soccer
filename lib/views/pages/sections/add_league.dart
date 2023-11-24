import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '/exports/exports.dart';
import '/services/league_service.dart';

class AddLeague extends StatefulWidget {
  const AddLeague({super.key});

  @override
  State<AddLeague> createState() => _AddLeagueState();
}

class _AddLeagueState extends State<AddLeague> {
  final leagueNameController = TextEditingController();
  var kickOffController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
          child: Consumer<AppController>(builder: (context, controller, x) {
            kickOffController.text = controller.matchDateId["date"];
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 13),
                    child: Text(
                      "Provide league information",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: streamData == null
                              ? Image.asset("assets/images/default.jpeg",
                                  width: 80, height: 80, fit: BoxFit.cover)
                              : Image.memory(imageData!,
                                  width: 80, height: 80, fit: BoxFit.cover),
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
                    controller: leagueNameController,
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                    titleText: "League Name",
                    hintText: "Enter league name",
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    enableBorder: true,
                  ),
                  CustomButton(
                    onPress: () {
                      if (leagueNameController.text.isEmpty) {
                        showMessage(
                            msg: "Please fill all the fields",
                            color: Colors.red);
                        Routes.popPage();
                      } else {
                        LeagueService().createLeague(
                          {
                            "name": leagueNameController.text,
                            "stream": streamData,
                            "length": fileLength,
                            "filename": fileName
                          },
                        );
                      }
                    },
                    text: "Create a league",
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
