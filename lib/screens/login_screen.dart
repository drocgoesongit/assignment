import 'dart:developer';
import 'package:assignment/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assignment/constants/color_const.dart';
import 'package:assignment/constants/text_const.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/signup_screen.dart';
import 'package:assignment/viewmodel/authentication_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Sign In",
                      style: kMainTitleBoldTextStyle,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Consumer<AuthenticationViewmodel>(
                          builder: (context, model, child) => ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: ContinuousRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  side: BorderSide(
                                    color: softGrayStrokeCustomColor,
                                    width: 2,
                                  )),
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                model.validateEmail(value);
                                return model.emailError
                                    ? 'Please enter a valid email address'
                                    : null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade50,
                                labelStyle: kSmallParaTextStyle,
                                labelText: 'Email',
                                border: InputBorder.none, // Remove the border
                                errorText: model.emailError
                                    ? 'Please enter a valid email address'
                                    : null,
                                errorStyle: kSmallParaTextStyle.copyWith(
                                    color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Consumer<AuthenticationViewmodel>(
                          builder: (context, model, child) => ClipPath(
                            clipper: ShapeBorderClipper(
                              shape: ContinuousRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  side: BorderSide(
                                    color: softGrayStrokeCustomColor,
                                    width: 2,
                                  )),
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              validator: (value) {
                                model.validatePassword(value);
                                return model.passwordError
                                    ? 'Password must be at least 6 characters long'
                                    : null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue.shade50,
                                labelStyle: kSmallParaTextStyle,
                                labelText: 'Password',
                                border: InputBorder.none, // Remove the border
                                errorText: model.passwordError
                                    ? 'Password must be at least 6 characters long'
                                    : null,
                                errorStyle: kSmallParaTextStyle.copyWith(
                                    color: Colors.red, fontSize: 12),
                                suffixIcon: IconButton(
                                  color: Colors.black,
                                  icon: Icon(_obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Consumer<AuthenticationViewmodel>(
                  builder: (context, model, child) => ClipPath(
                    clipper: const ShapeBorderClipper(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          var model = Provider.of<AuthenticationViewmodel>(
                              context,
                              listen: false);

                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.value.text;
                            String password = _passwordController.value.text;
                            log("email $email password $password");
                            bool? loggedIn = await model.loginWithEmail(
                                _emailController.value.text,
                                _passwordController.value.text);
                            if (loggedIn == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingScreen()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error "),
                                        content: Text(model.errorMessage),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok"))
                                        ],
                                      ));
                            }
                          } else {
                            model.validateEmail(_emailController.value.text);
                            model.validatePassword(
                                _passwordController.value.text);
                            log("Error while logging in with email and password");
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.46),
                            ),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(primaryBlueCustomColor),
                        ),
                        child: model.authenticationLoading == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Sign In",
                                style: kSmallParaTextStyle.copyWith(
                                    color: Colors.white, fontSize: 16),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "Don't have account? ",
                          style: kSmallParaTextStyle.copyWith(
                              color: Colors.black, fontSize: 12),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: kSmallParaTextStyle.copyWith(
                              color: Colors.blue, fontSize: 12),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
