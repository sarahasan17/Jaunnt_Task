class HomeResponse {
  List<ExperienceSubResponse> exp;
  List<PlaceHomeResponse> place;
  HomeResponse({required this.place, required this.exp});
  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
      place: List<PlaceHomeResponse>.from(
          json[""].map((x) => PlaceHomeResponse.fromJson(x))),
      exp: List<ExperienceSubResponse>.from(
          json[""].map((x) => ExperienceSubResponse.fromJson(x))));
  Map<String, dynamic> toJson() => {
        "": List<dynamic>.from(exp.map((x) => x.toJson())),
        "": List<dynamic>.from(place.map((x) => x.toJson())),
      };
}

class ExperienceSubResponse {
  ExperienceSubResponse({
    required this.type,
    required this.id,
    required this.postedBy,
    required this.location,
    required this.discription,
    required this.images,
    required this.category,
    required this.tags,
    required this.travelMode,
    required this.groupSize,
    required this.budget,
    required this.tripTime,
    required this.dateOfTrip,
    required this.likes,
    required this.likedBy,
    required this.placeId,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String type;
  late final String id;
  late final String postedBy;
  late final String location;
  late final String discription;
  late final List<String> images;
  late final List<dynamic> category;
  late final List<String> tags;
  late final String travelMode;
  late final int groupSize;
  late final String budget;
  late final String tripTime;
  late final String dateOfTrip;
  late final int likes;
  late final List<dynamic> likedBy;
  late final String placeId;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  ExperienceSubResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['_id'];
    postedBy = json['postedBy'];
    location = json['location'];
    discription = json['discription'];
    images = List.castFrom<dynamic, String>(json['images']);
    category = List.castFrom<dynamic, dynamic>(json['category']);
    tags = List.castFrom<dynamic, String>(json['tags']);
    travelMode = json['travelMode'];
    groupSize = json['groupSize'];
    budget = json['budget'];
    tripTime = json['tripTime'];
    dateOfTrip = json['dateOfTrip'];
    likes = json['likes'];
    likedBy = List.castFrom<dynamic, dynamic>(json['likedBy']);
    placeId = json['placeId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['_id'] = id;
    _data['postedBy'] = postedBy;
    _data['location'] = location;
    _data['discription'] = discription;
    _data['images'] = images;
    _data['category'] = category;
    _data['tags'] = tags;
    _data['travelMode'] = travelMode;
    _data['groupSize'] = groupSize;
    _data['budget'] = budget;
    _data['tripTime'] = tripTime;
    _data['dateOfTrip'] = dateOfTrip;
    _data['likes'] = likes;
    _data['likedBy'] = likedBy;
    _data['placeId'] = placeId;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class PlaceHomeResponse {
  PlaceHomeResponse({
    required this.type,
    required this.id,
    required this.placeName,
    required this.placeLocation,
    required this.description,
    required this.transportMode,
    required this.tripTime,
    required this.bestTime,
    required this.groupSize,
    required this.coverPhoto,
    required this.images,
    required this.category,
    required this.tags,
    required this.length,
    required this.thingsToDo,
    required this.itenirary,
    required this.similarPlaces,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.lat,
    required this.lng,
  });
  late final String type;
  late final String id;
  late final String placeName;
  late final String placeLocation;
  late final String description;
  late final String transportMode;
  late final String tripTime;
  late final String bestTime;
  late final int groupSize;
  late final String coverPhoto;
  late final List<dynamic> images;
  late final List<String> category;
  late final List<String> tags;
  late final double length;
  late final List<ThingsToDo> thingsToDo;
  late final List<Itenirary> itenirary;
  late final List<dynamic> similarPlaces;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final double lat;
  late final double lng;

  PlaceHomeResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['_id'];
    placeName = json['placeName'];
    placeLocation = json['placeLocation'];
    description = json['description'];
    transportMode = json['transportMode'];
    tripTime = json['tripTime'];
    bestTime = json['bestTime'];
    groupSize = json['groupSize'];
    coverPhoto = json['coverPhoto'];
    images = List.castFrom<dynamic, dynamic>(json['images']);
    category = List.castFrom<dynamic, String>(json['category']);
    tags = List.castFrom<dynamic, String>(json['tags']);
    length = json['length'];
    thingsToDo = List.from(json['thingsToDo'])
        .map((e) => ThingsToDo.fromJson(e))
        .toList();
    itenirary =
        List.from(json['itenirary']).map((e) => Itenirary.fromJson(e)).toList();
    similarPlaces = List.castFrom<dynamic, dynamic>(json['similarPlaces']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['_id'] = id;
    _data['placeName'] = placeName;
    _data['placeLocation'] = placeLocation;
    _data['description'] = description;
    _data['transportMode'] = transportMode;
    _data['tripTime'] = tripTime;
    _data['bestTime'] = bestTime;
    _data['groupSize'] = groupSize;
    _data['coverPhoto'] = coverPhoto;
    _data['images'] = images;
    _data['category'] = category;
    _data['tags'] = tags;
    _data['length'] = length;
    _data['thingsToDo'] = thingsToDo.map((e) => e.toJson()).toList();
    _data['itenirary'] = itenirary.map((e) => e.toJson()).toList();
    _data['similarPlaces'] = similarPlaces;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class ThingsToDo {
  ThingsToDo({
    required this.title,
    required this.description,
    required this.id,
  });
  late final String title;
  late final String description;
  late final String id;

  ThingsToDo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['_id'] = id;
    return _data;
  }
}

class Itenirary {
  Itenirary({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.id,
  });
  late final String time;
  late final String title;
  late final String subtitle;
  late final String description;
  late final String id;

  Itenirary.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['description'] = description;
    _data['_id'] = id;
    return _data;
  }
}
