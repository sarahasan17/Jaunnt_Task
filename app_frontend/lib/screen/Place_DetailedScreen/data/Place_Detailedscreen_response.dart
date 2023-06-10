import 'package:flutter/cupertino.dart';

class Place_DetailedResponse {
  String id;
  String placeName;
  String description;
  String transportMode;
  String tripTime;
  String bestTime;
  int groupSize;
  List<String> images;
  List<String> tags;
  double? distance;
  List<ThingsToDo> thingsToDo;
  List<Itenirary> itenirary;
  Place_DetailedResponse(
      {required this.description,
      required this.id,
      this.distance,
      required this.tripTime,
      required this.groupSize,
      required this.bestTime,
      required this.images,
      required this.itenirary,
      required this.placeName,
      required this.tags,
      required this.thingsToDo,
      required this.transportMode});
  factory Place_DetailedResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return Place_DetailedResponse(
      description: json["description"],
      id: json["_id"],
      tripTime: "10",
      //distance: 5,
      /**category: List<String>.from(json["category"].map((x) => x.toString())),**/
      groupSize: json["groupSize"],
      bestTime: json["bestTime"],
      images: List<String>.from(json["images"].map((x) => x.toString())),
      itenirary: List<Itenirary>.from(
          json["itinerary"].map((x) => Itenirary.fromJson(x))),
      placeName: json["name"],
      tags: List<String>.from(json["tags"].map((x) => x.toString())),
      thingsToDo: List<ThingsToDo>.from(
          json["thingsToDo"].map((x) => ThingsToDo.fromJson(x))),
      transportMode: "car",
    );
  }

  Map<String, dynamic> toJson() => {
        //"tripTime": tripTime,
        "description": description,
        "_id": id,
        "travelMode": transportMode,
        "tags": List<dynamic>.from(tags.map((x) => x.toString())),
        "name": placeName,
        /** "category": List<dynamic>.from(category.map((x) => x.toString())),**/
        "groupSize": groupSize,
        "bestTime": bestTime,
        "images": List<dynamic>.from(images.map((x) => x.toString())),
        //"distance": distance,
        "thingsToDo": List<ThingsToDo>.from(thingsToDo.map((x) => x.toJson())),
        "itinerary": List<Itenirary>.from(itenirary.map((x) => x.toJson())),
      };
}

class ThingsToDo {
  String title;
  String description;
  String id;
  ThingsToDo(
      {required this.title, required this.description, required this.id});
  factory ThingsToDo.fromJson(Map<String, dynamic> json) => ThingsToDo(
      title: json["title"], description: json["description"], id: json["_id"]);
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "_id": id,
      };
}

class Location {
  double lat;
  double lng;
  Location({required this.lat, required this.lng});
  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(lat: json["lat"], lng: json["lng"]);
  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}

class Itenirary {
  String time;
  String title;
  String subtitle;
  String description;
  String id;
  Itenirary(
      {required this.time,
      required this.title,
      required this.description,
      required this.id,
      required this.subtitle});
  factory Itenirary.fromJson(Map<String, dynamic> json) => Itenirary(
      time: json["time"],
      title: json["title"],
      description: json["description"],
      id: json["_id"],
      subtitle: json["subtitle"]);
  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
        "description": description,
        "_id": id,
        "subtitle": subtitle
      };
}
