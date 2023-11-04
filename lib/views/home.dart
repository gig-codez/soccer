import 'package:soccer/widgets/DrawerWidget.dart';

import '/exports/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String ext = "assets/bottom_navs/";
  List<Map<String, dynamic>> bottomNavs = [
    {"label": "Home", "icon": "home.svg"},
    {"label": "Home", "icon": "home.svg"},
    {"label": "Home", "icon": "home.svg"},
    {"label": "Home", "icon": "home.svg"},
    {"label": "Home", "icon": "home.svg"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scora'),
        actions: [
          TapEffect(
            onClick: () {},
            child: SvgPicture.asset("assets/search.svg"),
          ),
          const SizedBox.square(
            dimension: 30,
          ),
        ],
      ),
      body: PageView(
        children: [],
      ),
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          bottomNavs.length,
          (index) => BottomNavigationBarItem(
            label: bottomNavs[index]['label'],
            icon: SvgPicture.asset(
              ext + bottomNavs[index]['icon'],
            ),
          ),
        ),
      ),
    );
  }
}
