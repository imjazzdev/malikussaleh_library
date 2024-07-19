import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malikussaleh_library/components/main_navigator.dart';
import 'package:malikussaleh_library/views/mahasiswa/home.dart';
import 'package:malikussaleh_library/views/signup.dart';

import '../constants/constant.dart';
import 'admin/home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future getDataUser() async {
    var user = await FirebaseFirestore.instance
        .collection('DATA_USER')
        .doc(Constant.EMAIL)
        .get();
    Constant.USERNAME = user['nama'].toString();
    Constant.NIM = user['nim'].toString();
    Constant.EMAIL = user['email'].toString();
    print('USER LOGIN');
    print('Nama : ${Constant.USERNAME}');
    print('Nim : ${Constant.NIM}');
    print('Email : ${Constant.EMAIL}');
  }

  bool isVisible = true;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/profile.png',
                height: 200,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ]),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: InputBorder.none, labelText: 'Email'),
                    ),
                    const Divider(),
                    TextField(
                      controller: password,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                      },
                      child: Text('Sign Up')),
                  TextButton(onPressed: () {}, child: Text('Forgot password')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (email.text == 'admin' && password.text == 'admin#123') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeAdminPage(),
                          ),
                          (route) => false);
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.text, password: password.text);

                        Constant.EMAIL = await FirebaseAuth
                            .instance.currentUser!.email
                            .toString();
                        getDataUser();

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainNavigator(),
                            ),
                            (route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.warning,
                            title: 'Email & password salah. Coba lagi',
                            btnOkOnPress: () {},
                          ).show();

                          email.clear();
                          password.clear();
                        } else if (e.code == 'user-not-found') {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'User tidak ditemukan. Coba lagi',
                            btnOkOnPress: () {},
                          ).show();

                          email.clear();
                          password.clear();
                        } else {
                          // ignore: use_build_context_synchronously
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.warning,
                            title: 'Periksa internet anda',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                    }
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MainNavigator(),
                    //     ),
                    //     (route) => false);
                  },
                  child: const Text('Sign In'))
            ],
          ),
        ),
      ),
    );
  }
}
