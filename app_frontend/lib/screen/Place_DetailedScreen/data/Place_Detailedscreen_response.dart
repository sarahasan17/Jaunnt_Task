class Place_DetailedResponse {
  String id;
  String placeName;
  String placeLocation;
  String description;
  String transportMode;
  int tripTime;
  String bestTime;
  String groupSize;
  String coverPhoto;
  List<String> images;
  List<String> category;
  List<String> tags;
  int distance;
  int length;
  List<ThingsToDo> thingsToDo;
  List<Itenirary> itenirary;
  List<String> similarPlaces;
  String createdAt;
  String updatedAt;
  Place_DetailedResponse(
      {required this.description,
      required this.id,
      required this.length,
      required this.distance,
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
  factory Place_DetailedResponse.fromJson(Map<String, dynamic> json) =>
      Place_DetailedResponse(
          description: json["description"],
          id: json["_id"],
          length: json["length"],
          distance: json["distance"],
          updatedAt: json["updatedAt"],
          createdAt: json["createdAt"],
          category: json["category"],
          tripTime: json["tripTime"],
          groupSize: json["groupSize"],
          bestTime: json["bestTime"],
          coverPhoto: json["coverPhoto"],
          images: json["images"],
          itenirary: List<Itenirary>.from(
              json["itenirary"].map((x) => Itenirary.fromJson(x))),
          placeLocation: json["placeLocation"],
          placeName: json["placeName"],
          similarPlaces: json["similarPlaces"],
          tags: json["tags"],
          thingsToDo: List<ThingsToDo>.from(
              json["thingsToDo"].map((x) => ThingsToDo.fromJson(x))),
          transportMode: json["similarPlaces"]);
  Map<String, dynamic> toJson() => {
        "description": description,
        "_id": id,
        "transportMode": transportMode,
        "tags": tags,
        "similarPlaces": similarPlaces,
        "placeName": placeName,
        "placeLocation": placeLocation,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "category": category,
        "tripTime": tripTime,
        "groupSize": groupSize,
        "bestTime": bestTime,
        "coverPhoto": coverPhoto,
        "images": images,
        "length": length,
        "distance": distance,
        "thingsToDo": List<dynamic>.from(thingsToDo.map((x) => x.toJson())),
        "itenirary": List<dynamic>.from(itenirary.map((x) => x.toJson())),
      };
}

class ThingsToDo {
  String title;
  String description;
  String id;
  ThingsToDo(
      {required this.title, required this.description, required this.id});
  factory ThingsToDo.fromJson(Map<String, dynamic> json) =>
      ThingsToDo(title: "title", description: "description", id: "_id");
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
      time: "time",
      title: "title",
      description: "description",
      id: "_id",
      subtitle: "subtitle");
  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
        "description": description,
        "_id": id,
        "subtitle": subtitle
      };
}
