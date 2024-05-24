import '/exports/exports.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, controller, child) {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            RadioListTile(
              title: const Text("Light Theme"),
              value: controller.mode == ThemeMode.light ? 1 : 0,
              groupValue: 1,
              onChanged: (x) {
                controller.setMode(ThemeMode.light);

                Routes.popPage();
              },
            ),
            RadioListTile(
              title: const Text("Dark Theme"),
              value: controller.mode == ThemeMode.dark ? 1 : 0,
              groupValue: 1,
              onChanged: (x) {
                controller.setMode(ThemeMode.dark);
                Routes.popPage();
              },
            ),
            RadioListTile(
              title: const Text("System Theme"),
              value: controller.mode == ThemeMode.system ? 1 : 0,
              groupValue: 1,
              onChanged: (x) {
                controller.setMode(ThemeMode.dark);
                Routes.popPage();
              },
            )
          ],
        ),
      );
    });
  }
}
