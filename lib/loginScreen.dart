// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepartt/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(label: Text("Email")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your Email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(label: Text("Password")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your password";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _auth
                      .signInWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                    return ToastMessage().toastmsj("Login Successfully");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    return ToastMessage().toastmsj(error.toString());
                  });
                }
              },
              child: loading == true
                  ? const CircularProgressIndicator()
                  : const Text("Login"))
        ],
      ),
    );
  }
}

class ToastMessage {
  void toastmsj(String msg) {
    Fluttertoast.showToast(
        msg: "Login Succesfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 208, 164, 160),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
