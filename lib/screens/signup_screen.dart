import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../database.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  Future<void> signUp() async {
    bool isSuccess = false;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      String? userId = userCredential.user?.uid;


      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'username': _userNameController.text,
        'email': _emailTextController.text,
        'password':_passwordTextController.text,
      });

      isSuccess = true;
    } catch (error) {
      print("Sign Up Error: ${error.toString()}");
    }

    showDialog(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/animations/filler_watermelon.json'),
              SizedBox(height: 16),
              Text(
                isSuccess ? "User created: ${_userNameController.text}" : "Could not create user!",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert dialog
                if (isSuccess) {
                  navigateWithLoading(context, HomeScreen(username: _userNameController.text,)); // Navigate to the home screen
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        // Background Image
        Image.asset(
          'assets/travel_3.jpg', // Replace with your image asset path
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1),

              CustomLogoIcon(),
              Text(
                "Sign Up!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                child: reusableTextField("Enter Email ID",
                    Icons.email_outlined, false, _emailTextController),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                child: reusableTextField("Enter Username",
                    Icons.person_outline, false, _userNameController),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                child: reusableTextField("Enter Password", Icons.lock_outline,
                    true, _passwordTextController),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                context,
                "SIGN UP",
                  signUp,(){}),


    SizedBox(height: MediaQuery
        .of(context)
        .size
        .height * 0.05),

    ],
    ),
    ),
    ],
    ),
    );
    }
  }

