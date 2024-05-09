import '/models/table_model.dart';
import '/services/table_service.dart';

import '/exports/exports.dart';

class EditTable extends StatefulWidget {
  final Message data;
  const EditTable({super.key, required this.data});

  @override
  State<EditTable> createState() => _EditTableState();
}

class _EditTableState extends State<EditTable> {
  var wonController = TextEditingController();
  var loseController = TextEditingController();
  var drawController = TextEditingController();
  var goalsScoredController = TextEditingController();
  var goalsConcededController = TextEditingController();
  @override
  void initState() {
    super.initState();
    wonController.text = widget.data.won.toString();
    loseController.text = widget.data.lose.toString();
    drawController.text = widget.data.draw.toString();
    goalsScoredController.text = widget.data.goalsScored.toString();
    goalsConcededController.text = widget.data.goalsConceded.toString();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
          children: [
            Text(
              "Edit ${widget.data.team.name}'s Data",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox.square(dimension: 20),
            CommonTextField(
              titleText: "Won",
              enableBorder: true,
              hintText: "e.g 0",
              controller: wonController,
            ),
            CommonTextField(
              titleText: "Draw",
              enableBorder: true,
              hintText: "e.g 0",
              controller: drawController,
            ),
            CommonTextField(
              titleText: "Lose",
              enableBorder: true,
              hintText: "e.g 0",
              controller: loseController,
            ),
            CommonTextField(
              titleText: "Goals Scored",
              enableBorder: true,
              hintText: "e.g 0",
              controller: goalsScoredController,
            ),
            CommonTextField(
              titleText: "Goals Conceded",
              enableBorder: true,
              hintText: "e.g 0",
              controller: goalsConcededController,
            ),
            const SizedBox.square(dimension: 30),
            CustomButton(
              onPress: () {
                if (wonController.text.isEmpty ||
                    loseController.text.isEmpty ||
                    drawController.text.isEmpty ||
                    goalsScoredController.text.isEmpty ||
                    goalsConcededController.text.isEmpty) {
                  showMessage(
                    msg: "Please fill all the fields",
                  );
                } else {
                  TableService().updateTableData(
                    widget.data.id,
                    {
                      "teamId": widget.data.team.id,
                      "won": wonController.text,
                      "draw": drawController.text,
                      "lose": loseController.text,
                      "goals_scored": goalsScoredController.text,
                      "goals_conceded": goalsConcededController.text,
                    },
                  );
                }
              },
              text: "Save Changes",
            ),
            const SizedBox.square(dimension: 100),
          ],
        ),
      ),
    );
  }
}
