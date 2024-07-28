import 'package:samba_stats/controllers/player_controller.dart';

import '../../../../services/player_service.dart';
import '/exports/exports.dart';
import 'transfer_player.dart';

class ViewTransfers extends StatefulWidget {
  final String league;
  final String leagueId;
  const ViewTransfers({
    super.key,
    required this.league,
    required this.leagueId,
  });

  @override
  State<ViewTransfers> createState() => _ViewTransfersState();
}

class _ViewTransfersState extends State<ViewTransfers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${widget.league}\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Transfers",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<PlayerController>(
          builder: (context, controller, x) {
            if (mounted) {
              controller.fetchTransfers(widget.leagueId);
            }
            return controller.isTransferring == false
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.transfers.isEmpty
                    ? const Center(
                        child: Text(
                          "No transfers found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.transfers.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              showAdaptiveDialog(
                                  context: context,
                                  barrierColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black26
                                      : Colors.white54,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                      shadowColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black26
                                              : Colors.white54,
                                      elevation: 5,
                                      title: const Text("Transfer Details"),
                                      content: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.person),
                                              title: Text(
                                                controller
                                                    .transfers[index].name,
                                              ),
                                            ),
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.date_range),
                                              title: Text(
                                                controller
                                                    .transfers[index].createdAt
                                                    .formatedDate(),
                                              ),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.sports_football),
                                              title: Text(
                                                controller.transfers[index]
                                                    .oldTeam.name,
                                              ),
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.arrow_forward),
                                              title: Text(
                                                controller
                                                    .transfers[index].team.name,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Routes.popPage();
                                          },
                                          child: const Text("Close"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            PlayerService.deleteTransfer(
                                                    controller
                                                        .transfers[index].id)
                                                .then((value) {
                                              controller.transfers
                                                  .removeAt(index);
                                              if (value) {
                                                showMessage(
                                                  msg: value,
                                                  color: Colors.green.shade600,
                                                );
                                                Routes.popPage();
                                              }
                                            });
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: TransferPlayer(
                              player: controller.transfers[index],
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
