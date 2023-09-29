import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninja_id/screens/reset_password.dart';
import 'package:ninja_id/screens/signup_screen.dart';
import '../reusable_widgets/current_user_class.dart';
import '../reusable_widgets/reusable_widgets.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final CurrentUserModel _currentUserModel = CurrentUserModel();

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();

  Future<String?> getUsernameFromUserId(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        return userSnapshot['username'] as String?;
      } else {
        return null; // User not found or username doesn't exist
      }
    } catch (error) {
      print("Error fetching username: ${error.toString()}");
      return null;
    }
  }

  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      String userId = userCredential.user?.uid ?? '';

      // Fetch the username from Firestore using the userId
      String? username = await getUsernameFromUserId(userId);

      if (username != null) {
        _currentUserModel.userId = userId;
        _currentUserModel.username = username;

        // Navigate to the HomeScreen while passing the username
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(username: username)),
        );
      }
    } catch (error) {
      // Handle sign-in error
      print("Sign In Error: ${error.toString()}");
    }
  }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/travel_1.jpg', // Replace with your image asset path
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Centered Content
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  CustomLogoIcon(),
                  SizedBox( height:20),
                  Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Discover Your Next Adventure!",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                    child: reusableTextField("Enter Email ID",
                        Icons.email_outlined, false, _emailTextController),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
                    child: reusableTextField("Enter Password",
                        Icons.lock_outline, true, _passwordTextController),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: forgotPassword(context),
                  ),
                  CustomButton(context, "SIGN IN", signIn,(){}),
                  signUpOption(),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(username: 'guest user',)),
                      );
                    },
                    child: Text(
                      "GUEST USER",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );

    // body:Container(
    //   decoration: BoxDecoration(
    //     color: Colors.blue,
    //   ),
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have account? ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            navigateWithLoading(context, SignUpScreen());
          },
          child: Container(
            height: 20, // Change the height to a reasonable value
            alignment: Alignment.center, // Align the text within the container
            child: const Text(
              "Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

Widget forgotPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword()))),
  );
}
