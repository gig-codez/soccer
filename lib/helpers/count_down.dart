// import 'dart:async';

// class MatchCountdown {
//  final int secondsRemaining;
//  final Timer timer;

//   MatchCountdown({required this.timer, required this.secondsRemaining});

//   void startCountdown(Function onTimerUpdate, Function onTimerFinish) {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (secondsRemaining > 0) {
//         secondsRemaining--;
//         onTimerUpdate(secondsRemaining);
//       } else {
//         timer.cancel();
//         onTimerFinish();
//       }
//     });
//   }

//   void cancelTimer() {
//     _timer?.cancel();
//   }
// }

// // Example usage:
// MatchCountdown countdown = MatchCountdown(600); // 10 minutes countdown
// countdown.startCountdown(
//   (secondsRemaining) {
//     // Update UI with remaining time
//     print('$secondsRemaining seconds remaining');
//   },
//   () {
//     // Switch to live mode
//     print('Match is starting. Switching to live mode!');
//   },
// );

// // Remember to cancel the timer when needed (e.g., when the app is closed)
// // countdown.cancelTimer();
