import '../../../../controllers/loader_controller.dart';
import '/services/fixture_service.dart';
import '/widgets/custom_divider.dart';
import '/exports/exports.dart';

class UpdateFixtureResults extends StatefulWidget {
  final String fixtureId;
  const UpdateFixtureResults({super.key, required this.fixtureId});

  @override
  State<UpdateFixtureResults> createState() => _UpdateFixtureResultsState();
}

class _UpdateFixtureResultsState extends State<UpdateFixtureResults> {
  final _homeScoreController = TextEditingController();
  final _awayScoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Consumer<LoaderController>(
            builder: (context,controller,child) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                    child: CustomDivider(text: "Update fixture"),
                  ),
                  CommonTextField(
                    titleText: "Home Score",
                    hintText: "Home Score",
                    controller: _homeScoreController,
                    enableBorder: true,
                    keyboardType: TextInputType.number,
                  ),
                  CommonTextField(
                    titleText: "Away Score",
                    controller: _awayScoreController,
                    enableBorder: true,
                    hintText: "Away Score",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox.square(
                    dimension: 20,
                  ),
                  CustomButton(
                    text: "Update Fixture",
                    buttonColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPress:  controller.isLoading ? (){}: () {
                      if (_homeScoreController.text.isEmpty ||
                          _awayScoreController.text.isEmpty) {
                        showMessage(
                          msg: "Please fill all the fields",
                          color: Colors.red,
                        );
                      } else {
                        controller.isLoading = true;
                        FixtureService.updateFixtureGoals({
                          "fixtureId": widget.fixtureId,
                          "homeGoals": _homeScoreController.text,
                          "awayGoals": _awayScoreController.text
                        });
                      }
                    },
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
