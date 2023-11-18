import '/exports/exports.dart';

class CompleteUserProfile extends StatefulWidget {
  const CompleteUserProfile({super.key});

  @override
  State<CompleteUserProfile> createState() => _CompleteUserProfileState();
}

class _CompleteUserProfileState extends State<CompleteUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 12.0),
        child: Column(
          children: [
            const SizedBox.square(
              dimension: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Routes.popPage();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Complete Your Profile\n ",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                  ),
                  TextSpan(
                    text:
                        "\nComplete your profile now, or you can skip and fill it out later..",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade300
                          : Colors.white12,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            CommonTextField(
              hintText: "John Doe",
              enableBorder: true,
              icon: Icons.person,
              titleText: "Full Name",
              keyboardType: TextInputType.name,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter name";
                }
                return null;
              },
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            CommonTextField(
              hintText: "+256-7XX-XXXX",
              enableBorder: true,
              icon: Icons.location_on,
              titleText: "Phone Number",
              keyboardType: TextInputType.streetAddress,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter location";
                }
                return null;
              },
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            CommonTextField(
              hintText: "XX/XX/XXXX",
              enableBorder: true,
              icon: Icons.calendar_month,
              titleText: "Date Of Birth",
              keyboardType: TextInputType.streetAddress,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter location";
                }
                return null;
              },
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  width: MediaQuery.of(context).size.width / 2.5,
                  buttonRadius: 50,
                  text: "Skip",
                  onPress: () => Routes.pushPage( Routes.home),
                ),
                CustomButton(
                  width: MediaQuery.of(context).size.width / 2.5,
                  onPress: () => Routes.pushPage( Routes.home),
                  opacity: 1,
                  textColor: Colors.white,
                  text: "Finish",
                  buttonRadius: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
