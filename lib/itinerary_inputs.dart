import 'package:flutter/material.dart';
import 'package:ninja_id/reusable_widgets/navigation_drawer.dart';
import 'package:ninja_id/reusable_widgets/reusable_widgets.dart';
import 'package:intl/intl.dart';
import 'package:ninja_id/reusable_widgets/travel_places.dart';
import 'package:ninja_id/screens/ai_itineraary.dart';

class ItineraryInputs extends StatefulWidget {
  final String username;
  final TravelPlaces travelPlace;

  ItineraryInputs({required this.travelPlace, required this.username});

  @override
  _ItineraryInputsState createState() => _ItineraryInputsState();
}

class _ItineraryInputsState extends State<ItineraryInputs> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController untilController = TextEditingController();
  final TextEditingController numPeopleController = TextEditingController();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end:
        DateTime.now().add(Duration(days: 3)), // Fixed to days instead of hours
  );

  String getFrom() {
    return DateFormat('dd/MM/yyyy').format(dateRange.start);
  }

  String getUntil() {
    return DateFormat('MM/dd/yyyy').format(dateRange.end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color.fromARGB(255, 233, 234, 235),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.house_outlined),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      drawer: NaviDrawer(
          username: widget.username, currentPage: 'itnineraryinputs'),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            widget.travelPlace.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 80),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'How Many People Are Traveling?',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 150, // Set the desired width for the box
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: TextFormField(
                        controller: numPeopleController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter here',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'From:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Until:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            text: getFrom(),
                            onClicked: () => pickDateRange(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_right, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ButtonWidget(
                            text: getUntil(),
                            onClicked: () => pickDateRange(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenerateItinerary(
                              numberOfPeople: numPeopleController.text,
                              dateRange: dateRange,
                              travelPlace: widget.travelPlace,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Itinerary!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 49, 0, 0),
                        ),
                      ),
                    ),
                  ],
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
      end: DateTime.now().add(Duration(days: 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange; // Update the date range and refresh UI
    });
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
