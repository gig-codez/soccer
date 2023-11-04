import '/exports/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          size: 25,
          iconSize: 25,
        ),
        ProfileWidget(
          titleText: "General",
          color: primaryColor,
          prefixIcon: "box.svg",
          size: 25,
          iconSize: 25,
        ),
        const ProfileWidget(
          titleText: "Notifications",
          prefixIcon: "notification.svg",
          color: Colors.deepPurple,
          size: 25,
          iconSize: 25,
        ),
        const ProfileWidget(
          titleText: "Privacy",
          color: Colors.blue,
          prefixIcon: "privacy.svg",
          size: 25,
          iconSize: 25,
        ),
        const ProfileWidget(
          titleText: "Help",
          prefixIcon: "help.svg",
          color: Colors.green,
          size: 25,
          iconSize: 25,
        ),
        const ProfileWidget(
          titleText: "Logout",
          prefixIcon: "logout.svg",
          color: Colors.redAccent,
          size: 25,
          iconSize: 25,
        )
      ],
    );
  }
}
