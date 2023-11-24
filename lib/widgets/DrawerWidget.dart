import '/exports/exports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Map<String, dynamic>> drawer = [
    {
      "name": "Leagues",
      "icon": "assets/icons/league.svg",
      "routes": Routes.leagues,
    },
    {
      "name": "Fixtures",
      "icon": "assets/icons/match.svg",
      "routes": Routes.fixtures
    },
    {
      "name": "Match Dates",
      "icon": "assets/icons/match.svg",
      "routes": Routes.matchdates
    },
    {
      "name": "AI",
      "icon": "assets/icons/ai.svg",
      "routes": "",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(20),
            child: Text(
              "Samba Stats",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...List.generate(
            drawer.length,
            (index) => ListTile(
              onTap: () {
                Routes.popPage();
                Routes.pushPage(drawer[index]['routes']);
              },
              leading: SvgPicture.asset("${drawer[index]['icon']}",
                  color: Colors.grey.shade400),
              title: Text(
                "${drawer[index]['name']}",
              ),
            ),
          )
        ],
      ),
    );
  }
}
