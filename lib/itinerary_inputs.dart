import 'package:flutter/material.dart';
import 'package:ninja_id/reusable_widgets/navigation_drawer.dart';
import 'package:ninja_id/reusable_widgets/reusable_widgets.dart';
import 'package:intl/intl.dart';
import 'package:ninja_id/reusable_widgets/travel_places.dart';
import 'package:ninja_id/screens/ai_itineraary.dart';

class ItineraryInputs extends StatelessWidget {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController untilController = TextEditingController();
  final TextEditingController numPeopleController = TextEditingController();
  final String username;
  final TravelPlaces travelPlace;

  ItineraryInputs({required this.travelPlace, required this.username});


  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(hours: 24 * 3)),
  );


  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('MM/dd/yyyy').format(dateRange.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.house_outlined),
                onPressed: () {
                  // Open the navigation drawer
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      drawer: NaviDrawer(username: username),
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          Image.asset(
            travelPlace.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 80),
          Center(
            child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'How Many People Are Traveling?',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 150, // Set the desired width for the box
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white), // Add border to the box
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white// Add border radius
                      ),
                      child: TextFormField(
                        controller: numPeopleController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'Enter number of people',contentPadding: EdgeInsets.symmetric(horizontal: 10), // Padding inside the box
                        border: InputBorder.none,),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'From:',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 170,),
                        Text(
                          'Until:',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],

                    ),

                    Row(

                      children: [

                        Expanded(
                          child: ButtonWidget(
                            text: getFrom(),
                            onClicked: () => pickDateRange(context), key: null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_right, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ButtonWidget(
                            text: getUntil(),
                            onClicked: () => pickDateRange(context), key: null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GenerateItinerary(
                            numberOfPeople: numPeopleController.text,
                            dateRange: dateRange,
                            travelPlace: travelPlace,
                          ),),
                        );
                      },
                      child: Text(
                        "Itinerary!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
        ),
          ),
        ],

      ),

    );

  }

 Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours:24*3)),
    );
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5),
        initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange ==null) return;
    dateRange = newDateRange;

 }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(20),
      backgroundColor: Colors.white,
    ),
    onPressed: onClicked,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    ),
  );
}
