// ignore_for_file: deprecated_member_use

import '/exports/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // selected nav item
  int selected = 0;

  final String ext = "assets/bottom_navs/";
  List<Map<String, dynamic>> bottomNavs = [
    {"label": "Home", "icon": "home.svg", "un": "home_un.svg"},
    {"label": "LiveScore", "icon": "livescore.svg", "un": "livescore_un.svg"},
    {"label": "Stats", "icon": "stats.svg", "un": "stats_un.svg"},
    {"label": "Pages", "icon": "page.svg", "un": "page_un.svg"},
    {"label": "Profile", "icon": "profile.svg", "un": "profile_un.svg"},
  ];
  // page controller
  final PageController pageController = PageController();

  // pages to render
  List<Widget> pages = [
    const HomePage(),
    const LiveScore(),
    const Stats(),
    const Pages(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        controller: pageController,
        itemBuilder: (context, page) => pages[page],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selected = index;
          });
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 700),
            curve: Curves.ease,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        selectedIconTheme: const IconThemeData(size: 30),
        currentIndex: selected,
        items: List.generate(
          bottomNavs.length,
          (index) => BottomNavigationBarItem(
            label: bottomNavs[index]['label'],
            icon: SvgPicture.asset(
              "$ext${selected == index ? bottomNavs[index]['icon'] : bottomNavs[index]['un']}",
              color: selected == index ? primaryColor : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
