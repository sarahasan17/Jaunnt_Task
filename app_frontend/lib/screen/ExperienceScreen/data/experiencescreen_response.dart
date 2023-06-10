class ExperienceResponse {
  ExperienceResponse(
      {required this.id,
      required this.description,
      required this.images,
      required this.tags,
      required this.travelMode,
      required this.groupSize,
      required this.budget,
      required this.tripDuration,
      required this.dateOfTrip,
      this.distance,
      required this.user,
      required this.place});
  Place place;
  String? distance;
  String id;
  String description;
  List<String> images;
  List<String> tags;
  String travelMode;
  int groupSize;
  int budget;
  int tripDuration;
  DateTime dateOfTrip;
  User user;
  factory ExperienceResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return ExperienceResponse(
        distance: "2",
        id: json['_id'],
        description: json['description'],
        images: List<String>.from(json["images"].map((x) => x.toString())),
        tags: List<String>.from(json["tags"].map((x) => x.toString())),
        travelMode: json['travelMode'],
        groupSize: json['groupSize'],
        budget: json['budget'],
        tripDuration: json['tripDuration'],
        dateOfTrip: DateTime.parse(json['dateOfTrip']),
        place: Place.fromJson(json['place']),
        user: User.fromJson(json['postedBy']));
  }

  Map<String, dynamic> toJson() => {
        //'distance': distance,
        '_id': id,
        'description': description,
        'images': List<String>.from(images.map((x) => x.toString())),
        'tags': List<String>.from(tags.map((x) => x.toString())),
        'travelMode': travelMode,
        'groupSize': groupSize,
        'budget': budget,
        'tripDuration': tripDuration,
        'dateOfTrip': dateOfTrip.toIso8601String(),
        'postedBy': user.toJson(),
        'place': place.toJson()
      };
}

/**
class User {
  User({
    required this.id,
    required this.fullName,
    required this.profilePhoto,
  });
  late final String id;
  late final String fullName;
  late final String profilePhoto;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['fullName'] = fullName;
    _data['profilePhoto'] = profilePhoto;
    return _data;
  }
}
**/
class Place {
  Place({required this.id, required this.name});
  late final String id;
  final String name;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: "name",
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    //_data["name"] = name;
    return _data;
  }
}

class User {
  User({required this.id, required this.name});
  late final String id;
  final String name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: "name",
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    //_data['name'] = name;
    return _data;
  }
}
