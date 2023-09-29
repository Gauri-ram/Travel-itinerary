import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final double height; // Height of the header
  final String imageAsset; // Image asset path
  final String title1; // Title string
  final String title2;
  const HomeHeader({
    Key? key,
    required this.height,
    required this.imageAsset,
    required this.title1,
    required this.title2,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            // Background Image
            Image.asset(
              imageAsset, // Replace with your image asset path
              width: double.infinity,
              height: height,
              fit: BoxFit.cover,
            ),
            // Centered Content
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Text(
                      title1,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      title2,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

    );
  }
}
