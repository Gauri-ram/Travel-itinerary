import 'package:flutter/material.dart';
import 'package:ninja_id/reusable_widgets/reusable_widgets.dart';
import 'package:ninja_id/screens/home_screen.dart';
import 'package:ninja_id/screens/signin_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NaviDrawer extends StatelessWidget {
  final String username; // Add this property
  final String currentPage;

  const NaviDrawer({
    required this.username,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250, // Set the desired height of the DrawerHeader
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLogoIcon(),
                  SizedBox(height: 20),
                  Text(
                    'User : $username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Container(
                width: 24,
                height: 24,
                child: Image.asset(
                  'assets/ar_icon.png', // your custom AR image
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(2),
              ),
              title: Text(
                'AR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tileColor: Colors.black,
              onTap: () async {
                final Uri url = Uri.parse('https://google.com');

                if (!await launchUrl(url,
                    mode: LaunchMode.externalApplication)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open the AR link')),
                  );
                }
              },
            ),
            ...[
              if (currentPage != 'home')
                ListTile(
                  leading: Icon(Icons.home_max_outlined),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                username: this.username,
                              )),
                    );
                  },
                ),
            ],
            ListTile(
              leading: Icon(Icons.login_outlined),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Enjoy your trip!',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
