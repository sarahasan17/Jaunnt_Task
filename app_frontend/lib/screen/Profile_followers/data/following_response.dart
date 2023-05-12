class FollowingResponse {
  String id;
  List<FollowingResponse2> following;
  FollowingResponse({this.id, this.following});
  factory FollowingResponse.fromJson(Map<String, dynamic> json) =>
      (FollowingResponse(
        id: json["_id"],
        following: List<FollowingResponse2>.from(
            json["following"].map((x) => FollowingResponse.fromJson(x))),
      ));
}

class FollowingResponse2 {
  String fullName;
  String profilePhoto;
  String id;
  FollowingResponse2({this.fullName, this.profilePhoto, this.id});
  factory FollowingResponse2.fromJson(Map<String, dynamic> json) =>
      (FollowingResponse2(
          fullName: json["fullName"],
          profilePhoto: json["profilePhoto"],
          id: json["_id"]));
  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profilePhoto": profilePhoto,
        "_id": id,
      };
}
