import 'package:intl/intl.dart';
import '/services/match_date_service.dart';

import '/exports/exports.dart';

class AddMatchDate extends StatefulWidget {
  const AddMatchDate({super.key});

  @override
  State<AddMatchDate> createState() => _AddMatchDateState();
}

class _AddMatchDateState extends State<AddMatchDate> {
  final kickOffController = TextEditingController();
  String selectedDate = "";
  final _formKey = GlobalKey<FormState>();
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
                    "Provide match date information",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () async {},
                  child: CommonTextField(
                    controller: kickOffController,
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                    titleText: "Kick Off Date",
                    hintText: "xxx/xx/xxxxx",
                    contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    enableBorder: true,
                    onChanged: (n) async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2060));
                      kickOffController.text =
                          DateFormat("EEE d MMM").format(date!);
                      setState(() {
                        selectedDate = date.toLocal().toString();
                      });
                    },
                  ),
                ),
                CustomButton(
                  onPress: () {
                    if (kickOffController.text.isEmpty) {
                      showMessage(
                          msg: "Please fill all the fields", color: Colors.red);
                      Routes.popPage();
                    } else {
                      MatchDateService.savedMatchDate(
                        {"date": selectedDate},
                      );
                    }
                  },
                  text: "Save match date",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
