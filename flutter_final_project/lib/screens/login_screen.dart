// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/forgot_password.dart';
import 'package:flutter_final_project/screens/signincode_screen.dart';
import 'package:flutter_final_project/widgets/bottom_navigator_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showLearnMoreText = false;
  bool _hidePassword = true;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigatorBar(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 37, 37, 37),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
              actionsPadding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              titlePadding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              title: const Text(
                'Email Not Verified',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height * 0.06,
                child: const Text(
                  'Please verify your email address before logging in.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              actions: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Divider(
                          color: Colors.white,
                          thickness: 0.1,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
        setState(() {});
      } else if (e.code == 'invalid-email') {
      } else {}
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 37, 37, 37),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
            actionsPadding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
            titlePadding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            title: const Text(
              'Incorrect password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Text(
                'Sorry, that password is incorrect for the account with the email address ${email.text}.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            actions: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.1,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ).catchError(
        (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('錯誤'),
                content: const Text('註冊時發生錯誤，請稍後再試。'),
                actions: [
                  TextButton(
                    child: const Text('確定'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          width: 120,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Help',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: email,
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid = value.length >= 5;
                      });
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email or phone number',
                      labelStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      fillColor: const Color.fromARGB(255, 44, 42, 42),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    controller: password,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = value.length >= 4;
                      });
                    },
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      fillColor: const Color.fromARGB(255, 44, 42, 42),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _isEmailValid && _isPasswordValid ? signIn : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_isEmailValid && _isPasswordValid)
                        ? const Color.fromRGBO(255, 0, 0, 1)
                        : Colors.transparent,
                    disabledBackgroundColor:
                        const Color.fromARGB(255, 102, 2, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(300, 38),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: (_isEmailValid && _isPasswordValid)
                          ? Colors.white
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  child: Text(
                    "OR",
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInCodeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 41, 37, 37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(300, 38),
                  ),
                  child: const Text(
                    'Use a Sign-In Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: (() => Get.to(const ForgotPasswordScreen())),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style:
                          const TextStyle(color: Colors.white60, fontSize: 14),
                      children: [
                        const TextSpan(
                          text:
                              "Sign in is protected by Google reCAPTCHA to ensure you're not a bot. ",
                        ),
                        if (!_showLearnMoreText)
                          TextSpan(
                            text: "Learn more.",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _showLearnMoreText = true;
                                });
                              },
                          ),
                      ],
                    ),
                  ),
                ),
                if (_showLearnMoreText) const SizedBox(height: 15),
                if (_showLearnMoreText)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        children: [
                          TextSpan(
                            text:
                                "The information collected by Google reCAPTCHA is subject to the Google ",
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text: " and ",
                          ),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text:
                                ", and is used for providing, maintaining, and improving the reCAPTCHA service and for general security purposes(it is not used for personalized advertising by Google).",
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
    );
  }
}
