import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nama = TextEditingController();
  var email = TextEditingController();
  var nim = TextEditingController();
  var password = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: ListView(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/signup.png',
                    height: 200,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
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
                          controller: nama,
                          decoration: const InputDecoration(
                              border: InputBorder.none, labelText: 'Nama'),
                        ),
                        const Divider(),
                        TextField(
                          controller: nim,
                          decoration: const InputDecoration(
                              border: InputBorder.none, labelText: 'Nim'),
                        ),
                        const Divider(),
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
                              labelText: 'Password (min. 6 character)',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: Icon(isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          registerUser();
                        },
                        child: const Text('Sign Up')),
                  )
                ],
              ),
            ),
          ),
          isLoading == false
              ? SizedBox()
              : Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
    );
  }

  Future registerUser() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: password.text);

    final doc = await FirebaseFirestore.instance
        .collection('DATA_USER')
        .doc(email.text);

    final order = RegisterUserModel(
      nama: nama.text,
      email: email.text,
      nim: nim.text,
    );
    final json = order.toJson();
    await doc.set(json);
    // ignore: use_build_context_synchronously
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            title: 'Data berhasil ditambahkan',
            desc: 'Kembali ke halaman login',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
            btnCancelOnPress: () {})
        .show();
  }
}

class RegisterUserModel {
  final String nama, email, nim;

  RegisterUserModel({
    required this.nama,
    required this.email,
    required this.nim,
  });

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'email': email,
        'nim': nim,
      };
}
