import 'package:flutter/material.dart';
import 'package:ninja_id/reusable_widgets/reusable_widgets.dart';

import '../reusable_widgets/home_header.dart';
import '../reusable_widgets/navigation_drawer.dart';
import 'popularplaces.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        // title: Text("Home",
        // style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.house_outlined),
              onPressed: () {
                // Open the navigation drawer
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ],
      ),
      drawer: NaviDrawer(username: widget.username, currentPage: 'home'),
      body: SingleChildScrollView(
        child: Column(children: [
          HomeHeader(
            height: 400,
            imageAsset: 'assets/travel_1.jpg',
            title1: 'Travellers Itinerary!',
            title2: 'Discover Your Next Adventure!',
          ),
          SizedBox(height: 5),
          PopularPlaces(
            username: widget.username,
          ),
        ]),
      ),
    );
  }
}
