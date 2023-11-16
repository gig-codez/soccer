import '../../../exports/exports.dart';
import 'add_player.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  final playerController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  int players = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Bruno Fc\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Players",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: Text(
                        "Provide number of players",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: TextFormField(
                        controller: playerController,
                        onChanged: (x) {
                          setState(() {
                            playerController.text = x;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Players",
                          hintText: "Enter number of players",
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Routes.popPage(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Routes.popPage(context);
                            setState(() {
                              players = int.parse(playerController.text);
                            });
                          },
                          child: const Text("Add Players"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: playerController.text.isNotEmpty
            ? ListView.builder(
                itemCount: players,
                itemBuilder: (context, index) => ListTile(
                  leading: const CircleAvatar(
                    child: Text("P"),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) {
                            return BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return AddPlayer(
                                  name: "Player ${index + 1}",
                                  position: "Position ${index + 1}",
                                );
                              },
                            );
                          });
                    },
                    icon: const Icon(Icons.edit_rounded),
                  ),
                  title: Text("Player ${index + 1}"),
                ),
              )
            : Center(
                child: Text(
                  "No players added yet",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
      ),
    );
  }
}
