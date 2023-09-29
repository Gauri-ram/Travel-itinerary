import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TravelPlaces {
  final String name, image;

  TravelPlaces({
    required this.name,
    required this.image,
  });
}

List<TravelPlaces> travelPlace = [
  TravelPlaces(
    name: "Goa",
    image: "assets/goa1.jpg",
  ),
  TravelPlaces(
    name: "Norway",
    image: "assets/norway.jpg",
  ),
  TravelPlaces(
    name: "Ladakh",
    image: "assets/ladakh.jpg",
  ),
];
