import '/exports/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox.square(
            dimension: 50,
          ),
          ProfileWidget(
            titleText: "John Doe",
            prefixIcon: "profile.svg",
            subText: "johndoe@yourdomain.com",
            color: primaryColor,
            icon: Icons.edit,
            img: "assets/icons/logo.png",
            tile: true,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          const ProfileWidget(
            titleText: "Personal Info",
            prefixIcon: "profile.svg",
            color: Colors.deepOrangeAccent,
            size: 20,
            iconSize: 20,
          ),
          ProfileWidget(
            titleText: "General",
            color: primaryColor,
            prefixIcon: "box.svg",
            onPress: () {
              Routes.pushPage( Routes.settings);
            },
            size: 20,
            iconSize: 20,
          ),
          const ProfileWidget(
            titleText: "Notifications",
            prefixIcon: "notification.svg",
            color: Colors.deepPurple,
            size: 20,
            iconSize: 20,
          ),
          const ProfileWidget(
            titleText: "Privacy",
            color: Colors.blue,
            prefixIcon: "privacy.svg",
            size: 20,
            iconSize: 20,
          ),
          const ProfileWidget(
            titleText: "Help",
            prefixIcon: "help.svg",
            color: Colors.green,
            size: 20,
            iconSize: 20,
          ),
          ProfileWidget(
            titleText: "Logout",
            prefixIcon: "logout.svg",
            onPress: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog.adaptive(
                      icon: const Icon(
                        Icons.warning,
                        size: 50,
                      ),
                      content: const Text("Are you sure you want logout?"),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Routes.removePage(Routes.login),
                          child: const Text("Logout"),
                        ),
                        TextButton(
                          onPressed: () => Routes.popPage(),
                          child: const Text("Cancel"),
                        )
                      ],
                    );
                  });
            },
            color: Colors.redAccent,
            size: 20,
            iconSize: 20,
          )
        ],
      ),
    );
  }
}
