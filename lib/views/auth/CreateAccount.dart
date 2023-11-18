import '/exports/exports.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // form key
  final formKey = GlobalKey<FormState>();
  // variables to handle showing and hiding the password
  bool passShowHide = false;
  bool confirmPassShowHide = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 12.0),
        child: Form(
          key: formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: "Create an Account\n ",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                    ),
                    TextSpan(
                      text:
                          "\nEnter email and password. if you forget, then you will have to do forgot password.",
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
              CommonTextField(
                hintText: "example@gmail.com",
                enableBorder: true,
                icon: Icons.mail,
                titleText: "Email",
                keyboardType: TextInputType.emailAddress,
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 10,
                ),
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
                hintText: "******************",
                enableBorder: true,
                icon: Icons.lock,
                titleText: "Password",
                isObscureText: passShowHide,
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
                  setState(() {
                    passShowHide = !passShowHide;
                  });
                },
              ),
              const SizedBox.square(
                dimension: 20,
              ),
              CommonTextField(
                enableBorder: true,
                hintText: "******************",
                icon: Icons.lock,
                isObscureText: confirmPassShowHide,
                controller: confirmPasswordController,
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 10,
                ),
                enableSuffix: true,
                suffixIcon: confirmPassShowHide
                    ? Icons.visibility_off
                    : Icons.remove_red_eye,
                onTapSuffix: () {
                  setState(() {
                    confirmPassShowHide = !confirmPassShowHide;
                  });
                },
                titleText: "Confirm Password",
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
                dimension: 20,
              ),
              CustomButton(
                text: "Continue",
                textColor: Colors.white,
                opacity: 1,
                onPress: () {
                  // if (formKey.currentState!.validate()) {
                  // Routes.pushPage(context, Routes.home);
                  // }
                  Routes.pushPage(Routes.completeProfile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
