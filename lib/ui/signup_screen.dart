import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/notifiers/login_notifier.dart';
import 'package:weatherapp/ui/signin_screen.dart';
import 'package:weatherapp/utils/constants.dart';

import '../utils/colors.dart';
import '../utils/widgets/common.dart';
import '../utils/widgets/gradient_text.dart';

class SignUpScreen extends StatelessWidget {
  static const String route = "/signup-screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignUpForm();
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginNotifier loginNotifier;
  String _country = "";
  @override
  void initState() {
    super.initState();
    loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder<bool>(valueListenable: loginNotifier.isProgressing, builder: (context, value, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
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
                  vSpace(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      GradientText(
                        'Login',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        gradient: const LinearGradient(colors: [
                          color1,
                          color2,
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        onTap: () => Navigator.pushNamed(context, SignInScreen.route),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },);

  }

  _form(bool isLoading) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            vSpace(),
            TextFormField(
              controller: _fullNameController,
              decoration: textFieldInputDecoration("Full Name"),
              validator: (value) {
                return value != null && value.isNotEmpty ? null : "Please enter name";
              },
            ),
            vSpace(),
            TextFormField(
              controller: _phoneNumberController,
              decoration: textFieldInputDecoration("Phone Number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              // Only numbers can be entered
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter phone number";
                } else if (value.length != 10) {
                  return "Please enter valid phone number";
                } else {
                  return null;
                }
              },
            ),
            vSpace(),
            DropdownButtonFormField<String>(
              isDense: true,
              isExpanded: false,
              decoration: textFieldInputDecoration("Country"),
              items: ["India"]
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (String? value) {
                if(value!=null)
                _country = value;
              },
            ),
            vSpace(),
            TextFormField(
              controller: _emailController,
              decoration: textFieldInputDecoration("Email"),
              validator: (input) {
                return input != null && input.contains("@") && input.contains(".") ? null : "Check your email";
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 6) {
                    return "Enter at-least 6 chars";
                  } else {
                    return null;
                  }
                }),
            vSpace(),
            gradientButton("Signup", isLoading: isLoading, onTap: _doSignUp, disabled: false),
          ],
        ),
      ),
    );
  }

  _doSignUp() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await loginNotifier.doSignUp(name:_fullNameController.text,phoneNumber: _phoneNumberController.text,country: _country, emailAddress: _emailController.text, password: _passwordController.text);
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loginNotifier.message),
          duration: const Duration(seconds: 1),
        ),
      );
      if (isSuccess) {
        Future.delayed(const Duration(milliseconds: 250),() {
          Navigator.of(context).pushNamed(SignInScreen.route);
        },);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check Data')),
      );
    }
  }
}
