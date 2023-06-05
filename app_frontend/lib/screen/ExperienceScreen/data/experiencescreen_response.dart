class ExperienceResponse {
  ExperienceResponse({
    required this.exp,
    required this.user,
    required this.place,
  });
  late final Exp exp;
  late final User user;
  late final Place place;

  ExperienceResponse.fromJson(Map<String, dynamic> json) {
    exp = Exp.fromJson(json['exp']);
    user = User.fromJson(json['user']);
    place = Place.fromJson(json['place']);
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
  late final String placeId;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Exp.fromJson(Map<String, dynamic> json) {
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
    placeId = json['placeId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['placeId'] = placeId;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
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
  late final List<dynamic> distance;

  Place.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    placeName = json['placeName'];
    tripTime = json['tripTime'];
    groupSize = json['groupSize'];
    coverPhoto = json['coverPhoto'];
    category = List.castFrom<dynamic, String>(json['category']);
    distance = List.castFrom<dynamic, dynamic>(json['distance']);
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
