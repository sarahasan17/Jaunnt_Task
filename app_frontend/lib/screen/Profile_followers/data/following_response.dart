class FollowingResponse {
  String id;
  List<Following> following;
  FollowingResponse({required this.id, required this.following});
  factory FollowingResponse.fromJson(Map<String, dynamic> json) =>
      (FollowingResponse(
        id: json["_id"],
        following: List<Following>.from(
            json["following"].map((x) => FollowingResponse.fromJson(x))),
      ));
}

class Following {
  String fullName;
  String profilePhoto;
  String id;
  Following(
      {required this.fullName, required this.profilePhoto, required this.id});
  factory Following.fromJson(Map<String, dynamic> json) => (Following(
      fullName: json["fullName"],
      profilePhoto: json["profilePhoto"],
      id: json["_id"]));
  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profilePhoto": profilePhoto,
        "_id": id,
      };
}
