import '../../../exports/exports.dart';
import '../../../services/league_service.dart';
import '../../../tools/tools.dart';

class AddLeague extends StatefulWidget {
  const AddLeague({super.key});

  @override
  State<AddLeague> createState() => _AddLeagueState();
}

class _AddLeagueState extends State<AddLeague> {
  final leagueNameController = TextEditingController();
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
                  "Provide league information",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                        msg: "Please fill all the fields", color: Colors.red);
                  } else {
                    LeagueService()
                        .createLeague({"name": leagueNameController.text});
                  }
                },
                text: "Create a league",
              )
            ],
          ),
        ),
      ),
    );
  }
}
