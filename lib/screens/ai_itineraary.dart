// import 'dart:convert';
// import 'dart:math' as math;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
//
// class GenerateItinerary extends StatefulWidget {
//   const GenerateItinerary({super.key});
//
//   @override
//   State<GenerateItinerary> createState() => _GenerateItineraryState();
// }
//
// class _GenerateItineraryState extends State<GenerateItinerary> {
//   late TextEditingController controller;
//   late FocusNode focusNode;
//   final List<String> inputTags = [];
//   String response = '';
//   @override
//
//   void initState(){
//     controller = TextEditingController();
//     focusNode = FocusNode();
//     super.initState();
//   }
//
//   @override
//   void dispose(){
//     controller.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body:SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 children: [
//                   const Text(
//                     'What would you like to inclu de on your trip?',
//                     maxLines: 3,
//                     style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         TextFormField(
//                           autofocus:true,
//                           cursorColor: Colors.blue,
//                           focusNode: focusNode,
//                           controller: controller,
//                           onFieldSubmitted: (value){
//                             controller.clear();
//                             setState(() {
//                               inputTags.add(value);
//                               focusNode.requestFocus();
//                             });
//                             print(inputTags);
//                           },
//                           decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color:Theme.of(context).colorScheme.primary,
//                               ),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(5.5),
//                                 bottomLeft: Radius.circular(5.5))),
//                             enabledBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(),
//
//                             ),
//                             labelText: "Enter Tags...",
//                             labelStyle: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           color: Colors.green,
//                           child: Padding(
//                             padding: EdgeInsets.all(9),
//                             child: IconButton(
//                               onPressed: (){
//                                 if (controller.text.isNotEmpty){
//                                 setState(() {
//                                   inputTags.add(controller.text);
//                                   focusNode.requestFocus();
//                                 });
//                                 print(inputTags);
//                               }
//                               },
//                               icon: Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//
//                             ),
//                           ),
//                         )
//
//                       ],
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                     child: Wrap(
//                       children: [
//                         for(int i=0;i<inputTags.length;i++)
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal:5.0),
//                             child: Chip(
//                               backgroundColor: Color(math.Random().nextDouble().toInt())
//                               .withOpacity(0.1),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.5)),
//                               onDeleted: (){
//                                 setState(() {
//                                   inputTags.remove(inputTags[i]);
//                                   print(inputTags);
//                                 });
//                               },
//                               label: Text(inputTags[i]),
//                               deleteIcon: Icon(Icons.close,size: 20,),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     child: Center(
//                   child: SingleChildScrollView(
//                     child: Text(
//                       response,
//                       style:TextStyle(fontSize: 20),
//
//                   ),
//                     ),
//                   ),),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: ElevatedButton(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.auto_awesome),
//                           Text('Create Itinerary')
//                         ],
//                       ),
//                       onPressed: () async{
//                         setState(() => response = 'Generating...');
//                         var temp =
//                             await ChatGpt().askAI(inputTags.toString());
//                         setState(() => response = temp);
//                         //var temp = await
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//     );
//   }
// }
//
// abstract class OpenAiUsage{
//   Future<dynamic> askAI(String prompt);
// }
// class ChatGpt extends OpenAiUsage{
//   @override
//   Future<dynamic> askAI(String prompt) async{
//     try{
//       final response = await http.post(
//         Uri.parse('https://api.openai.com/v1/completions'),
//         headers:{
//           'Content-Type':'application/json',
//           'Authorization':'Bearer ${dotenv.env['token']}'
//         },
//         body: jsonEncode({
//           "model":"text-davinci-003",
//           "prompt":"Create itinerary day by day, from given details in brief points using"
//               " specific destinations & examples:\n$prompt",
//           "max_tokens":40,
//           "temperature":0.2,
//           "top_p":1,
//
//
//       },
//         ),
//       );
//
//       print(response.body);
//       return ResponseModel.fromJson(response.body).choices[0]['text'];
//     } catch(e){
//       return e.toString();
//
//     }
//   }
// }
// //RESPONSE MODEL
// class ResponseModel {
//   final String? id;
//   final String? object;
//   final String? model;
//   final List choices;
//
//   ResponseModel(
//       this.id,
//       this.object,
//       this.model,
//       this.choices,
//       );
//
//   ResponseModel copyWith({
//     String? id,
//     String? object,
//     String? model,
//     List? choices,
//   }) {
//     return ResponseModel(
//       id ?? this.id,
//       object ?? this.object,
//       model ?? this.model,
//       choices ?? this.choices,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'object': object,
//       'model': model,
//       'choices': choices,
//     };
//   }
//
//   factory ResponseModel.fromMap(Map<String, dynamic> map) {
//     return ResponseModel(
//       map['id'] as String,
//       map['object'] as String,
//       map['model'] as String,
//       List.from(
//         (map['choices'] as List),
//       ),
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory ResponseModel.fromJson(String source) =>
//       ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   String toString() {
//     return 'ResponseModel(id: $id, object: $object, model: $model, choices: $choices)';
//   }
//
//   @override
//   bool operator ==(covariant ResponseModel other) {
//     if (identical(this, other)) return true;
//
//     return other.id == id &&
//         other.object == object &&
//         other.model == model &&
//         listEquals(other.choices, choices);
//   }
//
//   @override
//   int get hashCode {
//     return id.hashCode ^ object.hashCode ^ model.hashCode ^ choices.hashCode;
//   }
// }

import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ninja_id/reusable_widgets/travel_places.dart';

import '../reusable_widgets/home_header.dart';
import '../reusable_widgets/navigation_drawer.dart';

class GenerateItinerary extends StatefulWidget {
  final String numberOfPeople;
  final DateTimeRange dateRange;
  final TravelPlaces travelPlace;

  GenerateItinerary({
    required this.numberOfPeople,
    required this.dateRange,
    required this.travelPlace
  });


  @override
  State<GenerateItinerary> createState() => _GenerateItineraryState();
}

class _GenerateItineraryState extends State<GenerateItinerary> {
  late TextEditingController controller;
  late FocusNode focusNode;
  final List<String> inputTags = [];
  String response = '';
  @override

  void initState(){
    controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              }
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            HomeHeader(height: 300,
              imageAsset: 'assets/travel_3.jpg',
              title1: 'What would you like to include on your trip?',
              title2: '',),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    // const Text(
                    //   'What would you like to include on your trip?',
                    //   maxLines: 3,
                    //   style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    // ),

                    Row(
                      children: [
                        Container(
                          width: 300,
                          child: TextFormField(
                            autofocus:true,
                            cursorColor: Colors.blue,
                            focusNode: focusNode,
                            controller: controller,
                            onFieldSubmitted: (value){
                              controller.clear();
                              setState(() {
                                inputTags.add(value);
                                focusNode.requestFocus();
                              });
                              print(inputTags);
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:Theme.of(context).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.5),
                                      bottomLeft: Radius.circular(5.5))),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(),

                              ),
                              labelText: "Enter Tags...",
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),

                        ),
                        Container(
                          color: Colors.green,
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.all(9),
                            child: IconButton(
                              onPressed: (){
                                if (controller.text.isNotEmpty){
                                  setState(() {
                                    inputTags.add(controller.text);
                                    focusNode.requestFocus();
                                  });
                                  controller.clear();
                                  print(inputTags);
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),

                            ),
                          ),
                        )

                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        children: [
                          for(int i=0;i<inputTags.length;i++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:5.0),
                              child: Chip(
                                backgroundColor: Color(math.Random().nextDouble().toInt())
                                    .withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.5)),
                                onDeleted: (){
                                  setState(() {
                                    inputTags.remove(inputTags[i]);
                                    print(inputTags);
                                  });
                                },
                                label: Text(inputTags[i]),
                                deleteIcon: Icon(Icons.close,size: 20,),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Text(
                              response,
                              style:TextStyle(fontSize: 20),

                            ),
                          ),
                        ),),
                    ),

                    SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome),
                              Text('Create Itinerary')
                            ],
                          ),
                          onPressed: () async{
                            setState(() => response = 'Generating...');
                            var temp =
                            await ChatGpt().askAI(inputTags.toString(), widget.travelPlace.name,
                               widget.numberOfPeople, widget.dateRange.toString(),
                            );
                            setState(() => response = temp);
                            //var temp = await
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class OpenAiUsage{
  Future<dynamic> askAI(String prompt, String travelPlace, String numberOfPeople, String dateRange);
}
class ChatGpt extends OpenAiUsage{
  @override
  Future<dynamic> askAI(String prompt, String travelPlace, String numberOfPeople, String dateRange) async{
    try{
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers:{
          'Content-Type':'application/json',
          'Authorization':'Bearer ${dotenv.env['token']}'
        },
        body: jsonEncode({
          "model":"text-davinci-003",
          "prompt":"Create every day of $travelPlace itinerary for $dateRange days & $numberOfPeople number of people and, from given details in brief points using"
              " specific destinations & examples:\n$prompt",
          "max_tokens":100,
          "temperature":0.2,
          "top_p":1,


        },
        ),
      );

      print(response.body);
      return ResponseModel.fromJson(response.body).choices[0]['text'];
    } catch(e){
      return e.toString();

    }
  }
}
//RESPONSE MODEL
class ResponseModel {
  final String? id;
  final String? object;
  final String? model;
  final List choices;

  ResponseModel(
      this.id,
      this.object,
      this.model,
      this.choices,
      );

  ResponseModel copyWith({
    String? id,
    String? object,
    String? model,
    List? choices,
  }) {
    return ResponseModel(
      id ?? this.id,
      object ?? this.object,
      model ?? this.model,
      choices ?? this.choices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'model': model,
      'choices': choices,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      map['id'] as String,
      map['object'] as String,
      map['model'] as String,
      List.from(
        (map['choices'] as List),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseModel(id: $id, object: $object, model: $model, choices: $choices)';
  }

  @override
  bool operator ==(covariant ResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.object == object &&
        other.model == model &&
        listEquals(other.choices, choices);
  }

  @override
  int get hashCode {
    return id.hashCode ^ object.hashCode ^ model.hashCode ^ choices.hashCode;
  }
}

