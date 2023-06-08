import 'package:flutter/cupertino.dart';

class Place_DetailedResponse {
  String id;
  String placeName;
  String placeLocation;
  String description;
  String transportMode;
  String tripTime;
  String bestTime;
  int groupSize;
  String coverPhoto;
  List<String> images;
  List<String> category;
  List<String> tags;
  double? distance;
  double length;
  List<ThingsToDo> thingsToDo;
  List<Itenirary> itenirary;
  List<String> similarPlaces;
  String createdAt;
  String updatedAt;
  double lat;
  double lng;
  Place_DetailedResponse(
      {required this.lat,
      required this.lng,
      required this.description,
      required this.id,
      required this.length,
      this.distance,
      required this.updatedAt,
      required this.createdAt,
      required this.category,
      required this.tripTime,
      required this.groupSize,
      required this.bestTime,
      required this.coverPhoto,
      required this.images,
      required this.itenirary,
      required this.placeLocation,
      required this.placeName,
      required this.similarPlaces,
      required this.tags,
      required this.thingsToDo,
      required this.transportMode});
  factory Place_DetailedResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return Place_DetailedResponse(
      lat: json["lat"],
      lng: json["lng"],
      description: json["description"],
      id: json["_id"],
      length: 10,
      distance: 5,
      updatedAt: json["updatedAt"],
      createdAt: json["createdAt"],
      category: List<String>.from(json["category"].map((x) => x.toString())),
      tripTime: "3",
      groupSize: json["groupSize"],
      bestTime: json["bestTime"],
      coverPhoto: json["coverPhoto"],
      images: List<String>.from(json["images"].map((x) => x.toString())),
      itenirary: List<Itenirary>.from(
          json["itenirary"].map((x) => Itenirary.fromJson(x))),
      placeLocation: json["placeLocation"],
      placeName: json["placeName"],
      similarPlaces:
          List<String>.from(json["similarPlaces"].map((x) => x.toString())),
      tags: List<String>.from(json["tags"].map((x) => x.toString())),
      thingsToDo: List<ThingsToDo>.from(
          json["thingsToDo"].map((x) => ThingsToDo.fromJson(x))),
      transportMode: json["transportMode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "_id": id,
        "transportMode": transportMode,
        "tags": List<dynamic>.from(tags.map((x) => x.toString())),
        "similarPlaces":
            List<dynamic>.from(similarPlaces.map((x) => x.toString())),
        "placeName": placeName,
        "placeLocation": placeLocation,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "category": List<dynamic>.from(category.map((x) => x.toString())),
        "tripTime": tripTime,
        "groupSize": groupSize,
        "bestTime": bestTime,
        "coverPhoto": coverPhoto,
        "images": List<dynamic>.from(images.map((x) => x.toString())),
        "length": length,
        "distance": distance,
        "thingsToDo": List<ThingsToDo>.from(thingsToDo.map((x) => x.toJson())),
        "itenirary": List<Itenirary>.from(itenirary.map((x) => x.toJson())),
        "lat": lat,
        "lng": lng
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
