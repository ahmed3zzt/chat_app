import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/widgets/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constans.dart';
import '../helper/show_snake_bar.dart';
import '../widgets/text_field.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: kPrimaryColor,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
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
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onchange: (data) {
                          email = data;
                        },
                        labelText: 'Email',
                        secureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onchange: (data) {
                          password = data;
                        },
                        labelText: 'Password',
                        secureText: true,
                      ),
                      CustomButton(
                        text: 'Register',
                        ontap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await registerUser();
                              Navigator.pushNamed(context, ChatPage.id);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnakeBar(context,
                                    'The password provided is too weak.');
                                isLoading = false;
                                setState(() {});
                              } else if (e.code == 'email-already-in-use') {
                                showSnakeBar(context,
                                    'The account already exists for that email.');

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
                            "Already Have an Acount?",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
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

  Future<void> registerUser() async {
    FirebaseAuth appUser = await FirebaseAuth.instance;
    appUser.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
