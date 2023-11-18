// ignore_for_file: file_names

import 'dart:async';

import '/exports/exports.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  Timer? _timer;
  int page = 0;
  @override
  void initState() {
    super.initState();
// controlling the sliding animation

    _timer = Timer.periodic(const Duration(milliseconds: 2300), (timer) {
      if (mounted) {
        setState(() {
          page += 1;
        });

        if (page >= 3) {
          setState(() {
            page = -1;
          });
        } else {
          pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 800),
            curve: Curves.decelerate,
          );
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  "assets/images/ball.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.2,
                  scale: 1,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome ",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Lottie.asset(
                        "assets/wave_emogi.json",
                        width: 60,
                        height: 60,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: PageView(
                    controller: pageController,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Don't miss a goal!, Get live match notifications and match results from your favorite teams. ",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 17),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Don't miss a goal!, Get live match notifications and match results from your favorite teams. ",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 17),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Don't miss a goal!, Get live match notifications and match results from your favorite teams. ",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    dotColor: Colors.grey.shade300,
                    activeDotColor: primaryColor,
                    type: WormType.normal,
                  ),
                )
              ],
            ),
            const SizedBox.square(dimension: 20),
            CustomButton(
              text: "Get Started",
              textColor: Colors.white,
              opacity: 1,
              onPress: () => Routes.pushPage(
              
                Routes.createAccount,
              ),
            ),
            const SizedBox.square(
              dimension: 10,
            ),
            CustomButton(
              text: "I Already Have an Account",
              onPress: () => Routes.pushPage( Routes.login),
            )
          ],
        ),
      ),
    );
  }
}
