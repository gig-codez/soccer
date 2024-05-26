import 'package:intl/intl.dart';
import '/controllers/match_date_controller.dart';
import '/exports/exports.dart';

class ShowMatchDates extends StatefulWidget {
  final String leagueId;
  const ShowMatchDates({super.key, required this.leagueId});

  @override
  State<ShowMatchDates> createState() => _ShowMatchDatesState();
}

class _ShowMatchDatesState extends State<ShowMatchDates> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Consumer<MatchDateController>(
            // future: MatchDateService.getMatchDates(widget.leagueId),
            builder: (context, controller, snapshot) {
          if (mounted) {
            controller.getMatchDates(widget.leagueId);
          }
          var matchs = controller.matchDates;
          return controller.loading == false
              ? matchs.isNotEmpty
                  ? ListView.builder(
                      itemCount: matchs.length,
                      itemBuilder: (context, index) {
                        return ProfileWidget(
                          titleText: DateFormat("EEE d MMM").format(
                            DateTime.parse(matchs[index].date),
                          ),
                          onPress: () {
                            context.read<AppController>().matchDateId = {
                              "date": DateFormat("EEE d MMM").format(
                                DateTime.parse(matchs[index].date),
                              ),
                              "id": matchs[index].id
                            };
                            Routes.popPage();
                          },
                          prefixIcon: "assets/football.svg",
                          color: Colors.green,
                          iconSize: 30,
                          size: 30,
                        );
                      },
                    )
                  : const Center(
                      child: Text("No match dates found"),
                    )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
        }),
      ),
    );
  }
}
