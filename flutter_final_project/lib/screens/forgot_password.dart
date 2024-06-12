// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_more_customizable/list_tile_more_customizable.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

List<String> options = ['電子郵件', '手機短訊(SMS)'];

class _SignUpScreenState extends State<ForgotPasswordScreen> {
  bool _showLearnMoreText = false;
  String currentOption = options[0];
  TextEditingController email = TextEditingController();

  resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
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
            'Email Sent',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.065,
            child: const Text(
              'Certification has been sent to your email. Please reset your password.',
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
                      '確定',
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
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 80, 0),
                child: Text(
                  "忘記電子郵件或密碼",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 160, 0),
                child: Text(
                  "您想透過甚麼方式重設密碼 ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: <Widget>[
                    ListTileMoreCustomizable(
                      minVerticalPadding: 0.0,
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      title: const Text(
                        '電子郵件',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      leading: Radio(
                        value: options[0],
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(
                            () {
                              currentOption = value.toString();
                            },
                          );
                        },
                      ),
                    ),
                    ListTileMoreCustomizable(
                      contentPadding: const EdgeInsets.all(0),
                      minVerticalPadding: 0.0,
                      dense: true,
                      title: const Text(
                        '手機短訊(SMS)',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      leading: Radio(
                        value: options[1],
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(
                            () {
                              currentOption = value.toString();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(
                  "您將收到一封電子郵件，請依照指示重設密碼 。",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 360,
                height: 50,
                child: TextField(
                  controller: email,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'name@example.com',
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    fillColor: const Color.fromARGB(255, 44, 42, 42),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: (() => resetPassword()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 119, 215),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  minimumSize: const Size(360, 50),
                ),
                child: const Text(
                  '寄電子郵件給我',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 0, 120, 0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  '我不記得我的電子郵件或電話號碼',
                  style: TextStyle(
                    color: Color.fromARGB(255, 29, 99, 222),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 40, 0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white60, fontSize: 16),
                    children: [
                      const TextSpan(
                        text: "此頁面受到 Google reCAPTCHA 保護 ，以確認您不是機器人 。",
                      ),
                      if (!_showLearnMoreText)
                        TextSpan(
                          text: "進一步了解 。",
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
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
    );
  }
}
