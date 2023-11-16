import 'package:soccer/views/pages/sections/add_fixture.dart';
import 'package:soccer/views/pages/sections/show_leagues.dart';

import '../../../exports/exports.dart';

class FixturesPage extends StatefulWidget {
  const FixturesPage({super.key});

  @override
  State<FixturesPage> createState() => _FixturesPageState();
}

class _FixturesPageState extends State<FixturesPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "No league selected\n",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              TextSpan(
                text: "Fixtures",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                transitionAnimationController: _controller,
                context: context,
                builder: (context) {
                  return BottomSheet(
                    animationController: _controller,
                    onClosing: () {},
                    builder: (context) {
                      return const ShowLeagues();
                    },
                  );
                },
              );
            },
            icon: SvgPicture.asset("assets/icons/match.svg"),
            label: const Text("Select a league"),
          )
        ],
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snap) {
            return snap.connectionState == ConnectionState.done
                ? ListView.builder(
                    itemBuilder: (context, index) => const Text("Fixtures"),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            transitionAnimationController: _controller,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return const AddFixture();
                  });
            }),
        label: Text(
          "Add a fixture",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
