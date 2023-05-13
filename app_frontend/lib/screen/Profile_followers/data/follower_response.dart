class FollowerResponse {
  String id;
  List<Followers> followers;
  FollowerResponse({required this.id, required this.followers});
  factory FollowerResponse.fromJson(Map<String, dynamic> json) =>
      (FollowerResponse(
        id: json["_id"],
        followers: List<Followers>.from(
            json["followers"].map((x) => FollowerResponse.fromJson(x))),
      ));
}

class Followers {
  String fullName;
  String profilePhoto;
  String id;
  Followers(
      {required this.fullName, required this.profilePhoto, required this.id});
  factory Followers.fromJson(Map<String, dynamic> json) => (Followers(
      fullName: json["fullName"],
      profilePhoto: json["profilePhoto"],
      id: json["_id"]));
  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profilePhoto": profilePhoto,
        "_id": id,
      };
}
