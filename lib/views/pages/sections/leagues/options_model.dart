import "/exports/exports.dart";
import 'add_league.dart';

class OptionsModel extends StatelessWidget {
  final String league;
  const OptionsModel({super.key, required this.league});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.24,
      child: Column(children: [
        ListTile(
          title: Text("Create a League",
              style: Theme.of(context).textTheme.titleMedium),
          leading: const Icon(Icons.add),
          onTap: () {
            Routes.popPage();
            showModalSheet(const AddLeague());
          },
        ),
        ListTile(
          title: Text("Attach Blogs",
              style: Theme.of(context).textTheme.titleMedium),
          leading: const Icon(Icons.add),
          onTap: () {
            Routes.popPage();
            // Routes.animateToPage(
            //   IndexBlogs(
            //     leagueName: league,
            //   ),
            // );
          },
        ),
      ]),
    );
  }
}
