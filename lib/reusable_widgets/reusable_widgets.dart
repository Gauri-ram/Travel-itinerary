import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninja_id/screens/home_screen.dart';

import '../screens/splash_screen.dart';
import '../screens/signin_screen.dart';

class CustomLogoIcon extends StatelessWidget {
  const CustomLogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 30, // Adjust the radius as needed
        backgroundColor: Colors.white, // Change the background color as needed
        child:
        Image.asset(
          'assets/travel.png', // Replace with your image asset path
          width: 70, // Adjust the width of the image
          height: 70,
        )
    );
  }
}



TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.8)),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container CustomButton(BuildContext context, String title, Function onTap, Function? onClicked) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
//
// class CustomPopupMenu extends StatelessWidget {
//   final void Function(String)? onItemSelected;
//
//   final BuildContext context;
//
//   const CustomPopupMenu({Key? key, required this.context, this.onItemSelected})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       itemBuilder: (BuildContext context) {
//         return [
//           const PopupMenuItem(
//             child: Text(
//               "Logout",
//               style: TextStyle(fontFamily: 'Schyler'),
//             ),
//             value: "logout",
//           ),
//           const PopupMenuItem(child: Text("Home"), value: "home"),
//         ];
//       },
//       onSelected: (value) {
//         if (value == "logout") {
//           // Handle logout and navigation to SignInScreen
//           FirebaseAuth.instance.signOut().then((value) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => SignInScreen()),
//             );
//           });
//         }
//         if (value == "home") {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen(username: ,)),
//           );
//         }
//       },
//     );
//   }
// }

void handleLogout(BuildContext context) {
  FirebaseAuth.instance.signOut().then((value) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  });
}

void navigateWithLoading(BuildContext context, Widget nextScreen) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Center(
            child: SpinKitDoubleBounce(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        ); // Show loading screen
      },
    ),
  );

  // Simulate some loading time
  Future.delayed(Duration(seconds: 1), () {
    Navigator.of(context).pop(); // Close the loading screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => nextScreen, // Navigate to the next screen
      ),
    );
  });
}
