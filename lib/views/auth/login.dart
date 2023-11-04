import '/exports/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // variables to handle showing and hiding the password
  bool passShowHide = false;

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox.square(
              dimension: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Routes.popPage(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox.square(
              dimension: 40,
            ),
            Text(
              "Hey There 👋",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            CommonTextField(
              hintText: "******************",
              enableBorder: true,
              icon: Icons.lock,
              titleText: "Email *",
              enableSuffix: true,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              suffixIcon:
                  passShowHide ? Icons.visibility_off : Icons.remove_red_eye,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
              onTapSuffix: () {
                setState(() {});
              },
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            CommonTextField(
              enableBorder: true,
              hintText: "******************",
              icon: Icons.lock,
              isObscureText: passShowHide,
              controller: passwordController,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              enableSuffix: true,
              suffixIcon:
                  passShowHide ? Icons.visibility_off : Icons.remove_red_eye,
              onTapSuffix: () {
                setState(() {});
              },
              titleText: "Password *",
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {},
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter confirm password";
                }
                return null;
              },
            ),
            const SizedBox.square(
              dimension: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "forgot password?",
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: primaryColor,
                        ),
                  ),
                )
              ],
            ),
            SizedBox.square(
              dimension: MediaQuery.of(context).size.width / 2,
            ),
            CustomButton(
              opacity: 1,
              textColor: Colors.white,
              text: "Sign In",
              onPress: () => Routes.pushPage(context, Routes.home),
            )
          ],
        ),
      ),
    );
  }
}
