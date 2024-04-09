import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:upoint_purchase_app/screens/homeScreen.dart';
import 'package:upoint_purchase_app/screens/signUpScreen.dart';

import '../const/colors.dart';
import '../const/spacing.dart';
import '../const/text_field.dart';
import '../services/loginService.dart';
import '../services/meService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true;
  late String token;
  final dio = Dio();
  bool isSignUpInProgress = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> login() async {
    if (isSignUpInProgress) return;

    setState(() {
      isSignUpInProgress = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print("email: $email");
    print("Pass: $password");

    try {
      // Call the login API using loginService
      // final token = await LoginService(, password);
      final tempLoginService = LoginService(dio);
      final loginService = await tempLoginService.login(email, password);
      token = loginService;
      print('success: $token');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(token: token),
        ),
      );
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Нууц үг буруу',
        desc: 'Та бүртгэлээ шалгаад дахин оролдоно уу?',
        btnOkOnPress: () {},
        btnOkColor: dangerColor6,
      ).show();
      print('Login failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          isSignUpInProgress = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor5, primaryColor8],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [
                h24(),
                Text(
                  'Нэвтрэх',
                  style: ktsBodyLargeBold.copyWith(color: whiteColor),
                ),
                h48(),
                h48(),
                Text(
                  'Тавтай морилно уу',
                  style: ktsBodyMassivePlusBold.copyWith(color: whiteColor),
                ),
                h24(),
                Text(
                  'Бүртгэлээ энд оруулна уу',
                  style: ktsBodyLarge.copyWith(color: whiteColor),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: screenWidth(context),
                      height: screenHeight(context) * 0.6,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: greyColor1.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                        child: Column(
                          children: [
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => HomeMaps(),
                            //       ),
                            //     );
                            //   },
                            //   child: Text("TEST"),
                            // ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: greyColor3, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: primaryColor6,
                                controller: emailController,
                                onSaved: (email) {},
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  labelStyle: TextStyle(
                                    color: greyColor5,
                                  ),
                                  hintText: "Username",
                                  hintStyle: ktsBodyRegular.copyWith(color: greyColor5),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto, // Set the floating label behavior
                                ),
                              ),
                            ),
                            h12(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: greyColor3, width: 1.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                cursorColor: primaryColor6,
                                controller: passwordController,
                                obscureText: _isPasswordHidden, // Use the state variable here
                                decoration: InputDecoration(
                                  labelText: "Нууц үг", // Set the label text for the floating label
                                  labelStyle: TextStyle(
                                    color: greyColor5, // You can adjust the style as needed
                                  ),
                                  hintText: "Нууц үг",
                                  hintStyle: ktsBodyRegular.copyWith(color: greyColor5),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto, // Enable floating label behavior
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                                      color: greyColor5, // Adjust the icon color as needed
                                    ),
                                    onPressed: () {
                                      // Toggle password visibility
                                      setState(() {
                                        _isPasswordHidden = !_isPasswordHidden;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: isSignUpInProgress
                                          ? null
                                          : () {
                                              login();
                                            },
                                      child: Container(
                                        width: screenWidth(context) * 0.8,
                                        decoration: BoxDecoration(
                                          color: primaryColor5,
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: isSignUpInProgress
                                              ? const Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                        whiteColor), // Adjust the progress indicator color here
                                                  ),
                                                )
                                              : Text(
                                                  'Нэвтрэх',
                                                  style: ktsBodyLarge.copyWith(color: whiteColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                        ),
                                      ),
                                    ),
                                    h12(),
                                    OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.only(bottom: 6, top: 6, right: 4.0, left: 4.0),
                                        side: BorderSide(color: primaryColor5, width: 1.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                      ),
                                      child: Container(
                                        width: screenWidth(context) * 0.8,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: BorderRadius.circular(24.0),
                                        ),
                                        child: Text(
                                          'Бүртгүүлэх',
                                          style: ktsBodyLarge.copyWith(color: primaryColor5),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            h24(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
