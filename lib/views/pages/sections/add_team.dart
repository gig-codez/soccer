import '../../../exports/exports.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({super.key});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  final teamNameController = TextEditingController();
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
              CommonTextField(
                titleText: "Team Name",
                hintText: "Enter team name",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                controller: teamNameController,
              ),
              CustomButton(
                onPress: () {},
                text: "Save",
              )
            ],
          ),
        ),
      ),
    );
  }
}
