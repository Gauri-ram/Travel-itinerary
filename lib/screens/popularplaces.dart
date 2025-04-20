import 'package:flutter/material.dart';
import 'package:ninja_id/reusable_widgets/navigation_drawer.dart';
import 'package:ninja_id/reusable_widgets/reusable_widgets.dart';
import 'package:ninja_id/reusable_widgets/section_title.dart';
import 'package:ninja_id/reusable_widgets/travel_places.dart';

import 'package:ninja_id/itinerary_inputs.dart';

class PopularPlaces extends StatelessWidget {
  final String username;
  const PopularPlaces({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SectionTitle(title: "Next Destination! ", press: () {}),
        ),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                travelPlace.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: PlaceCard(
                    travelPlace: travelPlace[index],
                    press: () {},
                    username: username,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.travelPlace,
    required this.press,
    required this.username,
  });
  final TravelPlaces travelPlace;
  final GestureTapCallback press;
  final String username;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailsPage(
                travelPlace: travelPlace,
                username: '',
              ),
            ));
      },
      child: SizedBox(
        width: screenWidth * 0.35,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.29,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(travelPlace.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.35,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    offset: Offset(0, 3), // Offset in (x,y) coordinates
                    blurRadius: 6, // Spread radius
                    spreadRadius: 0, // How far the shadow extends
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    travelPlace.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceDetailsPage extends StatelessWidget {
  final TravelPlaces travelPlace;
  final String username;

  const PlaceDetailsPage({
    required this.travelPlace,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
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
      drawer: NaviDrawer(
        username: username,
        currentPage: 'popularplaces',
      ),
      body: Center(
        child: Flexible(
          child: Column(
            children: [
              Image.asset(travelPlace.image), // Display the place image
              SizedBox(height: 12),
              Text(
                travelPlace.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Description of the place goes here...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              // Add more details about the place as needed
              //AttractionsWidget(travelPlace: travelPlace),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItineraryInputs(
                              travelPlace: travelPlace,
                              username: username,
                            )), // Navigate to ItineraryInputs
                  );
                },
                child: Text('Get Itinerary!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
