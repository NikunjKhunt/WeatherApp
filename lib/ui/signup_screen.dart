import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(Cons.space),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    logo(size.width),
                    header("Forcasting", fontSize: 30),
                    vSpace(),
                    subHeader("Enter your email address and password"),
                  ],
                ),
              ),
              SignUpForm(),
              // _success(size.width),
              vSpace(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  GradientText(
                    'Login',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    gradient: LinearGradient(colors: [
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
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _form();
  }

  _form() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            vSpace(),
            TextField(
              controller: _fullNameController,
              decoration: textFieldInputDecoration("Full Name"),
            ),
            vSpace(),
            TextField(
              controller: _phoneNumberController,
              decoration: textFieldInputDecoration("Phone Number"),
            ),
            vSpace(),

            DropdownButtonFormField<String>(
              isDense: true,
              isExpanded: false,
              decoration: textFieldInputDecoration("Country"),
              items: ["1", "2"]
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (String? value) {},
            ),
            // TextField(
            //   controller: _countryController,
            //   decoration: textFieldInputDecoration("Country"),
            // ),
            vSpace(),
            TextField(
              controller: _emailController,
              decoration: textFieldInputDecoration("Email"),
            ),
            vSpace(),
            TextField(
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
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            vSpace(),
            gradientButton("Signup", onTap: () {}, disabled: false),
          ],
        ),
      ),
    );
  }
}
