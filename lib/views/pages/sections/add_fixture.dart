import '../../../exports/exports.dart';

class AddFixture extends StatefulWidget {
  const AddFixture({super.key});

  @override
  State<AddFixture> createState() => _AddFixtureState();
}

class _AddFixtureState extends State<AddFixture> {
  final teamNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 13),
                child: Text(
                  "Add Fixture Information",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              CommonTextField(
                titleText: "Home Team",
                hintText: "Enter home team",
                icon: Icons.home_filled,
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: teamNameController,
              ),
              CommonTextField(
                titleText: "Away Team",
                icon: Icons.home_mini_rounded,
                hintText: "Enter away team",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: teamNameController,
              ),
              CommonTextField(
                titleText: "Minutes to be Played",
                icon: Icons.timelapse,
                hintText: "e.g 20 mins",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: teamNameController,
              ),
              CommonTextField(
                titleText: "Time of kick off",
                icon: Icons.timelapse,
                hintText: "e.g 20 mins",
                enableBorder: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                controller: teamNameController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Times Of Fixture",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile.adaptive(
                      value: 0,
                      groupValue: 1,
                      onChanged: (x) {},
                      title: const Text("2 Halfs"),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile.adaptive(
                      value: 0,
                      groupValue: 1,
                      onChanged: (x) {},
                      title: const Text("4 Quarters"),
                    ),
                  )
                ],
              ),
              CustomButton(
                onPress: () {},
                text: "Save",
              ),
              const SizedBox.square(
                dimension: 90,
              )
            ],
          ),
        ),
      ),
    );
  }
}
