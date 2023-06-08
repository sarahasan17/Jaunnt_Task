class ExperienceResponse {
  ExperienceResponse({
    required this.exp,
    required this.user,
    required this.place,
  });
  final Exp exp;
  final User user;
  final Place place;

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return ExperienceResponse(
        exp: Exp.fromJson(json['exp']),
        user: User.fromJson(json['user']),
        place: Place.fromJson(json['place']));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['exp'] = exp.toJson();
    _data['user'] = user.toJson();
    _data['place'] = place.toJson();
    return _data;
  }
}

class Exp {
  Exp({
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
    required this.placeId,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  final String id;
  final String postedBy;
  final String location;
  final String discription;
  final List<String> images;
  final List<String> category;
  final List<String> tags;
  final String travelMode;
  final int groupSize;
  final String budget;
  final String tripTime;
  final String dateOfTrip;
  final int likes;
  final String placeId;
  final String createdAt;
  final String updatedAt;
  final int V;

  factory Exp.fromJson(Map<String, dynamic> json) {
    return Exp(
        id: json['_id'],
        postedBy: json['postedBy'],
        location: json['location'],
        discription: json['discription'],
        images: List<String>.from(json["images"].map((x) => x.toString())),
        category: ["ok", "good"],
        tags: List<String>.from(json["tags"].map((x) => x.toString())),
        travelMode: json['travelMode'],
        groupSize: json['groupSize'],
        budget: json['budget'],
        tripTime: json['tripTime'],
        dateOfTrip: json['dateOfTrip'],
        likes: json['likes'],
        placeId: json['placeId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        V: json['__v']);
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'postedBy': postedBy,
        'location': location,
        'discription': discription,
        'images': List<String>.from(images.map((x) => x.toString())),
        'category': List<String>.from(category.map((x) => x.toString())),
        'tags': List<String>.from(tags.map((x) => x.toString())),
        'travelMode': travelMode,
        'groupSize': groupSize,
        'budget': budget,
        'tripTime': tripTime,
        'dateOfTrip': dateOfTrip,
        'likes': likes,
        'placeId': placeId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': V,
      };
}

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

class Place {
  Place({
    required this.id,
    required this.placeName,
    required this.tripTime,
    required this.groupSize,
    required this.coverPhoto,
    required this.category,
    required this.distance,
  });
  late final String id;
  late final String placeName;
  late final String tripTime;
  late final int groupSize;
  late final String coverPhoto;
  late final List<String> category;
  int distance;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['_id'],
      placeName: json['placeName'],
      tripTime: json['tripTime'],
      groupSize: json['groupSize'],
      coverPhoto: json['coverPhoto'],
      category: List<String>.from(json["category"].map((x) => x.toString())),
      distance: 0,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['placeName'] = placeName;
    _data['tripTime'] = tripTime;
    _data['groupSize'] = groupSize;
    _data['coverPhoto'] = coverPhoto;
    _data['category'] = category;
    _data['distance'] = distance;
    return _data;
  }
}
