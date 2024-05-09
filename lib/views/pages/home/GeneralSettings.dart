import '/widgets/ThemeWidget.dart';

import '/exports/exports.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("General Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.white12,
              child: ListTile(
                leading: const Icon(Icons.contrast),
                title: const Text("Theme"),
                subtitle: const Text("Light theme"),
                onTap: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                            // backgroundColor: Colors.transparent,
                            onClosing: () {},
                            builder: (context) {
                              return const ThemeWidget();
                            });
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
