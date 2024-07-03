import 'package:assignment/constants/color_const.dart';
import 'package:assignment/constants/text_const.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/viewmodel/authentication_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Sign up",
                    style: kMainTitleBoldTextStyle,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Consumer<AuthenticationViewmodel>(
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
                                  controller: _firstNameController,
                                  style: kSmallParaTextStyle,
                                  decoration: InputDecoration(
                                    labelStyle: kSmallParaTextStyle,
                                    labelText: 'First Name',
                                    filled: true,
                                    fillColor: Colors.blue.shade50,
                                    border: InputBorder.none,
                                    errorText: model.firstNameError
                                        ? 'First Name cannot be empty'
                                        : null,
                                    errorStyle: kSmallParaTextStyle.copyWith(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  validator: (value) {
                                    model.validateFirstName(value);
                                    return model.firstNameError
                                        ? 'First Name cannot be empty'
                                        : null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Consumer<AuthenticationViewmodel>(
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
                                  controller: _lastNameController,
                                  style: kSmallParaTextStyle,
                                  decoration: InputDecoration(
                                    labelStyle: kSmallParaTextStyle,
                                    labelText: 'Last Name',
                                    filled: true,
                                    fillColor: Colors.blue.shade50,
                                    border: InputBorder.none,
                                    errorText: model.lastNameError
                                        ? 'Last Name cannot be empty'
                                        : null,
                                    errorStyle: kSmallParaTextStyle.copyWith(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                  validator: (value) {
                                    model.validateLastName(value);
                                    return model.lastNameError
                                        ? 'Last Name cannot be empty'
                                        : null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Consumer<AuthenticationViewmodel>(
                        builder: (context, model, child) => ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: ContinuousRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                side: BorderSide(
                                  color: softGrayStrokeCustomColor,
                                  width: 2,
                                )),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: kSmallParaTextStyle,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              labelStyle: kSmallParaTextStyle,
                              labelText: 'Email',
                              border: InputBorder.none,
                              errorText: model.emailError
                                  ? 'Email cannot be empty'
                                  : null,
                              errorStyle: kSmallParaTextStyle.copyWith(
                                  color: Colors.red, fontSize: 12),
                            ),
                            validator: (value) {
                              model.validateEmail(value);
                              return model.emailError
                                  ? 'Email cannot be empty'
                                  : null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Consumer<AuthenticationViewmodel>(
                        builder: (context, model, child) => ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: ContinuousRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                side: BorderSide(
                                  color: softGrayStrokeCustomColor,
                                  width: 2,
                                )),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: kSmallParaTextStyle,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blue.shade50,
                              labelStyle: kSmallParaTextStyle,
                              labelText: 'Password',
                              border: InputBorder.none,
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
                            validator: (value) {
                              model.validatePassword(value);
                              return model.passwordError
                                  ? 'Password must be at least 6 characters long'
                                  : null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Consumer<AuthenticationViewmodel>(
                        builder: (context, model, child) => ClipPath(
                          clipper: const ShapeBorderClipper(
                            shape: ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool? success = await model.register(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                  );

                                  if (success != null && success) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (route) => false);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(model.errorMessage)),
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.46),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                    primaryBlueCustomColor),
                              ),
                              child: model.authenticationLoading == true
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Sign up",
                                      style: kSmallParaTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                              builder: (context) => LoginScreen()));
                    },
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: kSmallParaTextStyle.copyWith(
                              color: Colors.black, fontSize: 12),
                        ),
                        TextSpan(
                          text: "Sign in",
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
