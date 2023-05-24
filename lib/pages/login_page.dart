import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/widgets/button.dart';

import '../constans.dart';
import '../helper/show_snake_bar.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/scholar.png'),
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        labelText: 'Email',
                        secureText: false,
                        onchange: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        labelText: 'Password',
                        secureText: true,
                        onchange: (data) {
                          password = data;
                        },
                      ),
                      GestureDetector(
                        child: CustomButton(text: 'Login'),
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await loginUser();
                              Navigator.pushNamed(context, ChatPage.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnakeBar(
                                    context, 'No user found for that email.');

                                isLoading = false;
                                setState(() {});
                              } else if (e.code == 'wrong-password') {
                                showSnakeBar(context,
                                    'Wrong password provided for that user.');

                                isLoading = false;
                                setState(() {});
                              }
                            } catch (e) {
                              showSnakeBar(context, 'There Is An Error');

                              isLoading = false;
                              setState(() {});
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "don't have an acount?",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Color(0xffC7EDE6)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
