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
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/login.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 1.2,
              scale: 2,
            ),
            Text(
              "Hey 👋",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
            ),
            Text(
              "Welcome back.",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    fontSizeFactor: 1.2,
                  ),
            ),
            const SizedBox.square(
              dimension: 20,
            ),
            CommonTextField(
              hintText: "e.g example@gmail.com",
              enableBorder: true,
              icon: Icons.mail,
              titleText: "Email *",
              enableSuffix: false,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              suffixIcon:
                  passShowHide ? Icons.visibility_off : Icons.remove_red_eye,
              keyboardType: TextInputType.emailAddress,
              controller: passwordController,
              validate: (value) {
                if (value!.isEmpty) {
                  return "Please enter email";
                }
                return null;
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
            // SizedBox.square(
            //   dimension: MediaQuery.of(context).size.width / 2,
            // ),
            CustomButton(
              opacity: 1,
              textColor: Colors.white,
              text: "Sign In",
              onPress: () => Routes.pushPage(Routes.home),
            )
          ],
        ),
      ),
    );
  }
}
