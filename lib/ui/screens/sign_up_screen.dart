import 'package:basiclogin/utilities/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  } //now we have created these 2 and now also have to dispose them

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, right: 110),
              child: Image.asset(
                "assets/images/vector-3.png",
                width: 528,
                height: 300,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF755DC1),
                      fontSize: 27,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 56,
                    child: TextField(
                      controller: _username,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    height: 56,
                    child: TextField(
                      controller: _email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    width: 2000,
                    height: 56,
                    child: TextField(
                      controller: _password,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Create Password',
                        hintStyle: TextStyle(
                          color: Color(0xFF837E93),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 329,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final email = _email.text;
                            final password = _password.text;
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              //firebaseauth acutally is a future and return usercredential so we use await
                              email: email,
                              password: password,
                            );

                            final user = FirebaseAuth.instance.currentUser;

                            await user!.updateDisplayName(_username.text);
                            await user.reload();
                            await user.sendEmailVerification();
                            // print("User's Name: ${updateuser!.displayName}");
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              await showErrorDialog(
                                context,
                                'Weak Password',
                              );
                            } else if (e.code == 'email-already-in-use') {
                              await showErrorDialog(
                                context,
                                "Email already in use",
                              );
                            } else if (e.code == 'invalid-email') {
                              await showErrorDialog(
                                context,
                                "Invalid Email",
                              );
                            } else {
                              await showErrorDialog(
                                context,
                                "Error ${e.code}",
                              );
                            }
                          } catch (e) {
                            //catches any other that is not of firebaseauthException
                            await showErrorDialog(
                              context,
                              e.toString(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9F7BFF),
                        ),
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Have an account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF837E93),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      InkWell(
                        onTap: () {
                          widget.controller.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text(
                          'Log In ',
                          style: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
