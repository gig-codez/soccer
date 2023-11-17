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
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Accordion(
          headerBorderColorOpened: Colors.transparent,
          headerBorderWidth: 1,
          contentBorderWidth: 1,
          contentBackgroundColor:
              Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
          contentHorizontalPadding: 20,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          sectionOpeningHapticFeedback: SectionHapticFeedback.light,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: true,
              contentVerticalPadding: 20,
              leftIcon:
                  const Icon(Icons.sports_basketball, color: Colors.white),
              header: const Text("WOMEN FOOTBALL LEAGUE"),
              content: Column(
                children: [
                  InkWell(
                    onTap: () => Routes.pushPage(context, Routes.fixturePage),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Komafo  ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/leagues/komafo.jpeg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "0 - 0",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/leagues/amigos.jpeg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              "   Amigos united",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
