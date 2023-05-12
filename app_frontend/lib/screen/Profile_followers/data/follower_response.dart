class FollowerResponse {
  String id;
  List<FollowerResponse2> followers;
  FollowerResponse({this.id, this.followers});
  factory FollowerResponse.fromJson(Map<String, dynamic> json) =>
      (FollowerResponse(
        id: json["_id"],
        followers: List<FollowerResponse2>.from(
            json["followers"].map((x) => FollowerResponse.fromJson(x))),
      ));
}

class FollowerResponse2 {
  String fullName;
  String profilePhoto;
  String id;
  FollowerResponse2({this.fullName, this.profilePhoto, this.id});
  factory FollowerResponse2.fromJson(Map<String, dynamic> json) =>
      (FollowerResponse2(
          fullName: json["fullName"],
          profilePhoto: json["profilePhoto"],
          id: json["_id"]));
  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profilePhoto": profilePhoto,
        "_id": id,
      };
}
