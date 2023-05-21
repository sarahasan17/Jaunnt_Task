import 'package:flutter/material.dart';

import '../components/home/experience_card.dart';
import '../components/home/place_card.dart';

const double bodyPadding = 10;

const List<String> dummyImages = [
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/213/360/50213-backdrop-1651222749937-2.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/366/360/79366-backdrop-1680879935093-1.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/213/360/50213-backdrop-1651222749937-2.jpeg?country=in",
  "https://i7m8n5e3.stackpathcdn.com/images/ott/movies/366/360/79366-backdrop-1680879935093-1.jpeg?country=in",
];
const dummyUserProfileName = "Romanch Manchala";
const dummyPlace =
    "Kabini backwaters hvjhvhcgfc  gchv nvhfcvvjfhfchg gcghfxhvhgcxtdx b";
const dummyDescription =
    "One of the best places to visit in the morning. Bahut acha place bhai. Esa kabhi nahi dekha jeevan mein... now bloddy dummy text gchv nvhfcvvjfhfchg gcghfxhvhgcxtdx b";
const dummyPlaceDescription =
    "9 hrs trip time | 40 kms from you | Sunrise, Bike Ride";
const dummyPlaceTags = "Popular, Trending";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// TODO: AppBar
// TODO: Pull to refresh
// TODO: Save place flow
// TODO: Profile pic flow
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jaunnt"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(bodyPadding),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index % 4 == 0) {
                  return const ExperienceCard(
                    images: dummyImages,
                    profileName: dummyUserProfileName,
                    description: dummyDescription,
                    placeName: dummyPlace,
                  );
                }
                if (index % 4 == 1) {
                  return const PlaceCard(
                    images: dummyImages,
                    placeName: dummyPlace,
                    description: dummyPlaceDescription,
                    tags: dummyPlaceTags,
                  );
                }
                if (index % 4 == 2) {
                  return const ExperienceCard(
                    images: dummyImages,
                    profileName: dummyUserProfileName,
                    description: "",
                    placeName: dummyPlace,
                  );
                }
                return const PlaceCard(
                  images: dummyImages,
                  placeName: dummyPlace,
                  description: dummyPlaceDescription,
                  tags: dummyPlaceTags,
                );
              },
              itemCount: 10,
            ),
          ),
        ),
      ),
    );
  }
}
