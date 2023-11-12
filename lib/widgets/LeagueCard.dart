import '../exports/exports.dart';

class LeagueCard extends StatelessWidget {
  const LeagueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : Colors.white12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade100
                : Colors.white12,
            width: 2),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              leading: Image.asset("assets/images/nobg.png"),
              title: Text(
                "Local League",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: const Text("Group C"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 2, bottom: 2),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.white12,
            ),
          ),
          ListTile(
            leading: SizedBox.square(
              dimension: 30,
              child: Text(
                "Ft  ",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/leagues/otim.jpeg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text("OTIM F.C"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/leagues/timeout.jpeg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text("TimeOut F.C"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 2, bottom: 2),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.white12,
            ),
          ),
          // second team
          ListTile(
            leading: Text(
              "22:00",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/leagues/otim.jpeg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text("OTIM F.C"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/leagues/timeout.jpeg",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Text("TimeOut F.C"),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
