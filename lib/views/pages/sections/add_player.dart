import '../../../exports/exports.dart';

class AddPlayer extends StatelessWidget {
  final String? name;
  final String? position;
  AddPlayer({super.key, this.name, this.position});

  @override
  Widget build(BuildContext context) {
    final playerNameController = TextEditingController(text: name);

    final playerPositionController = TextEditingController(text: position);

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
                titleText: "Name",
                hintText: "e.g John Gum",
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                enableBorder: true,
              ),
              CommonTextField(
                controller: playerPositionController,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                titleText: "Position",
                hintText: "e.g Defender",
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                enableBorder: true,
              ),
              CustomButton(
                onPress: () {},
                text: "Save Player details",
              )
            ],
          ),
        ),
      ),
    );
  }
}
