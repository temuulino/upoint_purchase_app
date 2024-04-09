import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../const/colors.dart';
import '../const/spacing.dart';
import '../const/text_field.dart';
import '../services/signUpService.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isPasswordHidden = true;
  final dio = Dio();

  bool isSignUpInProgress = false;

  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> signUpResponse = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> signUp() async {
    if (isSignUpInProgress) return;

    setState(() {
      isSignUpInProgress = true;
    });

    String username = emailController.text.trim();
    String password = passwordController.text.trim();

    print("email: $username");
    print("Pass: $password");

    try {
      final tempUpdatePasswordService = UpdatePasswordService(dio);
      final updatePasswordService = await tempUpdatePasswordService.updatePassword(username, password);

      if (updatePasswordService.containsKey('errors')) {
        final errors = updatePasswordService['errors'] as Map<String, dynamic>;
        String errorMessage = errors.entries.map((e) => '${e.value.join(" ")}').join("\n");
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Алдаа',
          desc: errorMessage,
          btnOkOnPress: () {},
          btnOkColor: dangerColor6,
        ).show();
      } else {
        // Handle success case
        signUpResponse = updatePasswordService;
        print('success: $updatePasswordService');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'Амжилттай',
          desc: 'Амжилттай бүртгэгдлээ',
          btnOkOnPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          btnOkColor: successColor5,
        ).show();
      }
    } catch (e) {
      print('Signup failed: $e');
      String errorMessage = 'Та бүртгэлээ шалгаад дахин оролдоно уу?'; // Default error message
      if (e is DioError) {
        if (e.response != null && e.response!.statusCode == 422) {
          final responseData = e.response!.data;

          if (responseData.containsKey('errors')) {
            final errors = responseData['errors'] as Map<String, dynamic>;
            errorMessage = errors.entries.map((e) => '${e.value.join(" ")}').join("\n");
          }
        }
      }
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Алдаа',
        desc: errorMessage,
        btnOkOnPress: () {},
        btnOkColor: dangerColor6,
      ).show();
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor3, primaryColor5],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [
                h24(),
                Text(
                  'Бүртгүүлэх',
                  style: ktsBodyLargeBold.copyWith(color: whiteColor),
                ),
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
                h24(),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: screenWidth(context),
                      height: screenHeight(context),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: greyColor1.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: const Offset(0, -10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor3, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: primaryColor6,
                                  controller: lastNameController,
                                  // onSaved: (email) {},
                                  decoration: InputDecoration(
                                    labelText: "Овог",
                                    labelStyle: const TextStyle(
                                      color: greyColor5,
                                    ),
                                    hintText: "Овог",
                                    hintStyle: ktsBodyRegular.copyWith(color: greyColor5),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto, // Set the floating label behavior
                                  ),
                                ),
                              ),
                              h12(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor3, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: primaryColor6,
                                  controller: firstNameController,
                                  // onSaved: (email) {},
                                  decoration: InputDecoration(
                                    labelText: "Нэр",
                                    labelStyle: const TextStyle(
                                      color: greyColor5,
                                    ),
                                    hintText: "Нэр",
                                    hintStyle: ktsBodyRegular.copyWith(color: greyColor5),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto, // Set the floating label behavior
                                  ),
                                ),
                              ),
                              h12(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor3, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: primaryColor6,
                                  controller: emailController,
                                  // onSaved: (email) {},
                                  decoration: InputDecoration(
                                    labelText: "Email хаяг",
                                    labelStyle: const TextStyle(
                                      color: greyColor5,
                                    ),
                                    hintText: "Email хаяг",
                                    hintStyle: ktsBodyRegular.copyWith(color: greyColor5),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto, // Set the floating label behavior
                                  ),
                                ),
                              ),
                              h12(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor3, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: primaryColor6,
                                  controller: phoneController,
                                  // onSaved: (value) {}, // Uncomment and use if needed
                                  decoration: InputDecoration(
                                    labelText: "Утасны дугаар",
                                    labelStyle: TextStyle(
                                      color: greyColor5,
                                    ),
                                    hintText: "Утасны дугаар",
                                    hintStyle: ktsBodyRegular.copyWith(color: greyColor5),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto, // Set the floating label behavior
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Утасны дугаар оруулна уу'; // 'Please enter phone number'
                                    } else if (value.length != 8) {
                                      return 'Утасны дугаар нь 8 оронтой байх ёстой'; // 'Phone number must be 8 digits'
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                ),
                              ),
                              h12(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor3, width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: primaryColor6,
                                  controller: passwordController,
                                  obscureText: _isPasswordHidden, // Use the state variable here
                                  decoration: InputDecoration(
                                    labelText: "Нууц үг", // Set the label text for the floating label
                                    labelStyle: const TextStyle(
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
                              h12(),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: isSignUpInProgress
                                            ? null
                                            : () {
                                                if (_formKey.currentState!.validate()) {
                                                  signUp();
                                                }
                                              },
                                        child: Container(
                                          height: 50,
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
                                                    'Бүртгүүлэх',
                                                    style: ktsBodyLarge.copyWith(color: whiteColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
