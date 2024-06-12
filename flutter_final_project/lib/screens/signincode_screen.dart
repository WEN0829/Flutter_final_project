// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/home_screen.dart';
import 'package:flutter_final_project/screens/opt_screen.dart';
import 'package:get/get.dart';

class SignInCodeScreen extends StatefulWidget {
  const SignInCodeScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInCodeScreen> {
  bool _showLearnMoreText = false;
  bool _isEmailValid = false;
  bool _isPhoneValid = false;
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController controller = TextEditingController();

  sendCode() async {
    if (_isPhoneValid) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phonenumber.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error occured', e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(
              OptScreen(
                vid: vid,
              ),
            );
          },
          codeAutoRetrievalTimeout: (vid) {},
        );
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error occured', e.code);
      } catch (e) {
        Get.snackbar('Error occured', e.toString());
      }
    } else if (_isEmailValid) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: '', // 使用空密碼
        );

        User? user = userCredential.user;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
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
        } else {
          Get.to(const HomeScreen());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // 如果使用者不存在,創建新的使用者並發送驗證信
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email.text, password: '');
            User? user = userCredential.user;
            await user?.sendEmailVerification();
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
          } catch (e) {
            Get.snackbar('Error occured', e.toString());
          }
        } else {
          Get.snackbar('Error occured', e.code);
        }
      } catch (e) {
        Get.snackbar('Error occured', e.toString());
      }
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "Get your sign-in code",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid =
                            value.contains('@') && value.contains('.com');
                        _isPhoneValid = value.length == 10 &&
                            RegExp(r'^[0-9]+$').hasMatch(value);

                        if (_isEmailValid) {
                          email.text = value;
                        } else if (_isPhoneValid) {
                          phonenumber.text = value;
                        }
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
                ElevatedButton(
                  onPressed: (_isEmailValid || _isPhoneValid) ? sendCode : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_isEmailValid || _isPhoneValid)
                        ? const Color.fromRGBO(255, 0, 0, 1)
                        : const Color.fromARGB(255, 102, 2, 2),
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
                      color: (_isEmailValid || _isPhoneValid)
                          ? Colors.white
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Email or Phone Number?',
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
                        style: TextStyle(color: Colors.white60, fontSize: 14),
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
