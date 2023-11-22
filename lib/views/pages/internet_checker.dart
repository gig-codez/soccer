import '../../exports/exports.dart';

class InternetCheckWidget extends StatefulWidget {
  const InternetCheckWidget({super.key});

  @override
  State<InternetCheckWidget> createState() => _InternetCheckWidgetState();
}

class _InternetCheckWidgetState extends State<InternetCheckWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_bad_rounded, size: 60),
          Text("No Internet"),
          OutlinedButton(
            onPressed: () {},
            child: Text("Reload"),
          )
        ],
      ),
    );
  }
}
