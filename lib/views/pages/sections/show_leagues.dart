import '../../../exports/exports.dart';

class ShowLeagues extends StatefulWidget {
  const ShowLeagues({super.key});

  @override
  State<ShowLeagues> createState() => _ShowLeaguesState();
}

class _ShowLeaguesState extends State<ShowLeagues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.delayed(
            const Duration(seconds: 2),
          ),
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.done
                ? ListView.builder(itemBuilder: (context, index) {
                    return const ProfileWidget(
                      titleText: "League",
                      prefixIcon: "assets/icons/league.svg",
                    );
                  })
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
          },
        ),
      ),
    );
  }
}
