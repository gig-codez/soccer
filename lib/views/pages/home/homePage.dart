import '/widgets/DrawerWidget.dart';
import '/exports/exports.dart';
import '../sections/leagues/leagues.dart';

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
        title: const Text('Samba Stats'),
      ),
      drawer: const DrawerWidget(),
      body: const Leagues(),
    );
  }
}
