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
  TravelPlaces(
    name: "Pondicherry",
    image: "assets/pondicherry.jpg",
  ),
  TravelPlaces(
    name: "Spain",
    image: "assets/spain.jpg",
  ),
  TravelPlaces(
    name: "Switzerland",
    image: "assets/switzerland.jpg",
  ),
  TravelPlaces(
    name: "Singapore",
    image: "assets/singapore.jpg",
  ),
  TravelPlaces(
    name: "France",
    image: "assets/france.jpg",
  ),
  TravelPlaces(
    name: "Germany",
    image: "assets/germany.jpg",
  ),
  TravelPlaces(
    name: "Russia",
    image: "assets/russia.jpg",
  ),
  TravelPlaces(
    name: "Kenya",
    image: "assets/kenya.jpg",
  ),
  TravelPlaces(
    name: "Australia",
    image: "assets/australia.jpg",
  ),
  TravelPlaces(
    name: "Brazil",
    image: "assets/brazil.jpg",
  ),
  TravelPlaces(
    name: "Canada",
    image: "assets/canada.jpg",
  ),
  TravelPlaces(
    name: "China",
    image: "assets/china.jpg",
  ),
];
