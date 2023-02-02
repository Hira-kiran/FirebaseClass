import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Screen"),
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
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(label: Text("Password")),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _auth
                    .createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString())
                    .then((value) {
                  return ToastMessage().toastmsj("Singup Successfully");
                }).onError((error, stackTrace) {
                  return ToastMessage().toastmsj(error.toString());
                });
              },
              child: const Text("Sign Up"))
        ],
      ),
    );
  }
}

class ToastMessage {
  void toastmsj(String msg) {
    Fluttertoast.showToast(
        msg: "Signup Succesfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 208, 164, 160),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
