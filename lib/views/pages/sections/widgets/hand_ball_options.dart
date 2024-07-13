// ignore_for_file: slash_for_doc_comments

import 'package:samba_stats/services/player_service.dart';

import '../../../../controllers/player_controller.dart';
import '/exports/exports.dart';

class HandBallOptions extends StatefulWidget {
  final String playerId;
  final String leagueId;
  const HandBallOptions(
      {super.key, required this.playerId, required this.leagueId});

  @override
  State<HandBallOptions> createState() => _HandBallOptionsState();
}

class _HandBallOptionsState extends State<HandBallOptions> {
  final toController = TextEditingController();
  final glsController = TextEditingController();
  final astController = TextEditingController();
  final mxController = TextEditingController();
  final blkController = TextEditingController();
  final steController = TextEditingController();
  final ksController = TextEditingController();
  final twoMinController = TextEditingController();
  final rcController = TextEditingController();
  final shirtNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<PlayerController>(context)
        .fetchSingleHandBallPlayer(widget.playerId, widget.leagueId);
    // set default values
    toController.text =
        Provider.of<PlayerController>(context).handBallData.to.toString();
    glsController.text =
        Provider.of<PlayerController>(context).handBallData.gls.toString();
    astController.text =
        Provider.of<PlayerController>(context).handBallData.ast.toString();
    mxController.text =
        Provider.of<PlayerController>(context).handBallData.mx.toString();
    blkController.text =
        Provider.of<PlayerController>(context).handBallData.blk.toString();
    steController.text =
        Provider.of<PlayerController>(context).handBallData.ste.toString();
    ksController.text =
        Provider.of<PlayerController>(context).handBallData.ks.toString();
    twoMinController.text =
        Provider.of<PlayerController>(context).handBallData.twoMin.toString();
    rcController.text =
        Provider.of<PlayerController>(context).handBallData.rc.toString();
    shirtNumberController.text =
        Provider.of<PlayerController>(context).handBallData.shirtNo;
    // end of defaults
  }
// handBallOptions
/**
 *  "TO": 0,
        "GLS": 0,
        "AST": 0,
        "MX": 0,
        "BLK": 0,
        "STE": 0,
        "KS": 0,
        "TWO_MIN": 0,
        "RC": 0,
 */

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Handball options',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Consumer<PlayerController>(builder: (context, controller, x) {
          //
          if (mounted) {
            controller.fetchSingleHandBallPlayer(
              widget.playerId,
              widget.leagueId,
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
            children: [
              // Text(
              //   "Edit ${widget.data.team.name}'s Data",
              //   style: Theme.of(context).textTheme.titleMedium,
              // ),
              const SizedBox.square(dimension: 20),
              CommonTextField(
                titleText: "Shirt Number",
                enableBorder: true,
                hintText: "e.g 0",
                controller: shirtNumberController,
                readOnly: controller.isLoading,
              ),
              CommonTextField(
                titleText: "TO",
                enableBorder: true,
                hintText: "e.g 0",
                controller: toController,
                readOnly: controller.isLoading,
              ),
              CommonTextField(
                titleText: "GLS",
                enableBorder: true,
                hintText: "e.g 0",
                readOnly: controller.isLoading,
                controller: glsController,
              ),
              CommonTextField(
                titleText: "AST",
                enableBorder: true,
                hintText: "e.g 0",
                readOnly: controller.isLoading,
                controller: astController,
              ),
              CommonTextField(
                titleText: "MX",
                enableBorder: true,
                readOnly: controller.isLoading,
                hintText: "e.g 0",
                controller: mxController,
              ),
              CommonTextField(
                titleText: "BLK",
                enableBorder: true,
                hintText: "e.g 0",
                readOnly: controller.isLoading,
                controller: blkController,
              ),
              CommonTextField(
                titleText: "STE",
                enableBorder: true,
                readOnly: controller.isLoading,
                hintText: "e.g 0",
                controller: steController,
              ),
              CommonTextField(
                titleText: "KS",
                enableBorder: true,
                hintText: "e.g 0",
                readOnly: controller.isLoading,
                controller: ksController,
              ),
              CommonTextField(
                titleText: "2 Min",
                enableBorder: true,
                hintText: "e.g 0",
                readOnly: controller.isLoading,
                controller: twoMinController,
              ),
              const SizedBox.square(dimension: 30),
              CustomButton(
                loading: controller.isLoading,
                onPress: controller.isLoading
                    ? () {}
                    : () {
                        controller.isLoading = true;
                        //  send data to server
                        PlayerService.updateHandBallPlayer({
                          "player": widget.playerId,
                          "league": widget.leagueId,
                          "shirtNo": shirtNumberController.text,
                          "TO": toController.text,
                          "GLS": glsController.text,
                          "AST": astController.text,
                          "MX": mxController.text,
                          "BLK": blkController.text,
                          "STE": steController.text,
                          "KS": ksController.text,
                          "TWO_MIN": twoMinController.text,
                          "RC": rcController.text,
                        }).then((value) {
                          controller.isLoading = false;
                          Routes.popPage();
                        }).onError((error, stackTrace) {
                          controller.isLoading = false;
                          Routes.popPage();
                        });
                      },
                text: "Save Changes",
                buttonColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              const SizedBox.square(dimension: 100),
            ],
          );
        }),
      ),
    );
  }
}
