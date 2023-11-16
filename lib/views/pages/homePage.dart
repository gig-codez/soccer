import '../../widgets/DrawerWidget.dart';
import '/widgets/LeagueCard.dart';
import '/exports/exports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SportsChat'),
        actions: [
          TapEffect(
            onClick: () {},
            child: SvgPicture.asset(
              "assets/search.svg",
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          const SizedBox.square(
            dimension: 10,
          ),
          TapEffect(
            onClick: () => Routes.pushPage(context, Routes.notifications),
            child: const Icon(
              Icons.notifications_active,
            ),
          ),
          const SizedBox.square(
            dimension: 30,
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const LeagueCard();
              },
            )),
          ],
        ),
      ),
    );
  }
}
