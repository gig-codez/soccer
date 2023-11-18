import 'package:intl/intl.dart';

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
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Form(
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
                CommonTextField(
                  controller: leagueNameController,
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                  titleText: "League Name",
                  hintText: "Enter league name",
                  contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  enableBorder: true,
                ),
                InkWell(
                  onTap: () async {},
                  child: CommonTextField(
                    controller: kickOffController,
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                    titleText: "Kick Off Date",
                    hintText: "Enter league name",
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    enableBorder: true,
                    onChanged: (n) async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2060));
                      kickOffController.text =
                          DateFormat.yMMMMEEEEd().format(date!.toLocal());
                    },
                  ),
                ),
                CustomButton(
                  onPress: () {
                    if (leagueNameController.text.isEmpty) {
                      showMessage(
                          msg: "Please fill all the fields", color: Colors.red);
                      Routes.popPage();
                    } else {
                      LeagueService().createLeague(
                        {
                          "name": leagueNameController.text,
                          "date": kickOffController.text
                        },
                      );
                    }
                  },
                  text: "Create a league",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
