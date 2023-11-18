import '/exports/exports.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  // SharedPreferences _prefs =  await SharedPreferences.getInstance();
  int isLight = 1;
  int isDark = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, controller, child) {
      return SizedBox(
        height: 200,
        child: Column(
          children: [
            RadioListTile(
              title: const Text("Light Theme"),
              value: isLight,
              groupValue: 1,
              onChanged: (x) {
                controller.isDarkMode = false;
                if (!controller.isDarkMode) {
                  setState(() {
                    isDark = 0;
                    isLight = 1;
                  });
                }
                Routes.popPage();
              },
            ),
            RadioListTile(
              title: const Text("Dark Theme"),
              value: isDark,
              groupValue: 1,
              onChanged: (x) {
                controller.isDarkMode = true;
                if (controller.isDarkMode) {
                  setState(() {
                    isDark = 1;
                    isLight = 0;
                  });
                }
                Routes.popPage();
              },
            )
          ],
        ),
      );
    });
  }
}
