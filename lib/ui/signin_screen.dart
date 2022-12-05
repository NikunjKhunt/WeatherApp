import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/notifiers/login_notifier.dart';
import 'package:weatherapp/ui/signup_screen.dart';
import 'package:weatherapp/utils/constants.dart';

import '../utils/colors.dart';
import '../utils/widgets/common.dart';
import '../utils/widgets/gradient_text.dart';
import 'day_screen.dart';

class SignInScreen extends StatelessWidget {
  static const String route = "/signin-screen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignInForm();
  }

  _success(double screenWidth) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(Cons.space),
            child: Image.asset(
              "assets/images/success.png",
              width: screenWidth / 3,
            ),
          ),
          header("Congratulations", fontSize: 25),
          Container(
            margin: EdgeInsets.all(Cons.space),
            child: Center(
              child: header("Your Account Created Successfully", color: secondSuccessColor, isCenter: true),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late LoginNotifier loginNotifier;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final TextEditingController _emailController = TextEditingController(text: "nikunj@yopmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "123456");
  bool rememberMe = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ValueListenableBuilder<bool>(
      valueListenable: loginNotifier.isProgressing,
      builder: (context, value, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              padding: const EdgeInsets.all(Cons.space),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        logo(size.width),
                        header("Forcasting", fontSize: 30),
                        vSpace(),
                        subHeader("Enter your email address and password"),
                      ],
                    ),
                  ),
                  _form(value),
                  // _success(size.width),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      GradientText(
                        'Signup',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        gradient: const LinearGradient(colors: [
                          color1,
                          color2,
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        onTap: () => Navigator.pushNamed(context, SignUpScreen.route),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _form(bool isLoading) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            vSpace(),
            TextFormField(
              controller: _emailController,
              decoration: textFieldInputDecoration("Email"),
              validator: (input) {
                return input != null && input.contains("@") && input.contains(".") ? null : "Check your email";
              },
              onChanged: (value) {
                hasError = value != null && value.contains("@") && value.contains(".") ? false : true;
                setState(() {});
              },
            ),
            vSpace(),
            TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: textFieldInputDecoration(
                  "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  hasError = value != null && value.length >= 6 ? false : true;
                  setState(() {});
                },
                validator: (val) {
                  return val != null && val.length >= 6 ? null : "Enter at-least 6 chars";
                }),
            vSpace(),
            Row(
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: rememberMe,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),
                ),
                hSpace(),
                const Text("Remember Me"),
              ],
            ),
            vSpace(),
            gradientButton("Login", isLoading: isLoading, onTap: _doLogin, disabled: false),
          ],
        ),
      ),
    );
  }

  _doLogin() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await loginNotifier.doLogin(emailAddress: _emailController.text, password: _passwordController.text);
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<LoginNotifier>(context, listen: false).message),
          duration: const Duration(seconds: 1),
        ),
      );
      if (isSuccess) {
        Future.delayed(const Duration(milliseconds: 250),() {
            Navigator.of(context).pushNamed(DayScreen.route);
        },);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check Data')),
      );
    }
  }
}
