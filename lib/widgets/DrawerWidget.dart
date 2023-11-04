import '/exports/exports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Map<String, dynamic>> drawer = [
    {
      "name": "Football",
      "icon": "assets/football.svg",
    },
    {
      "name": "Tennis",
      "icon": "assets/tennis.svg",
    },
    {
      "name": "Basket",
      "icon": "assets/basket.svg",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(20),
            child: Text(
              "Scora",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...List.generate(
            drawer.length,
            (index) => ListTile(
              onTap: () {
                Routes.popPage(context);
              },
              leading: SvgPicture.asset("${drawer[index]['icon']}"),
              title: Text("${drawer[index]['name']}"),
            ),
          )
        ],
      ),
    );
  }
}
