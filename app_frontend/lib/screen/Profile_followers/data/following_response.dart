class FollowingResponse {
  String fullName;
  String profilePhoto;
  String id;
  FollowingResponse({this.fullName, this.profilePhoto, this.id});
  factory FollowingResponse.fromJson(Map<String, dynamic> json) =>
      (FollowingResponse(
          fullName: json["fullName"],
          profilePhoto: json["profilePhoto"],
          id: json["_id"]));
  Map<String, dynamic> toJson() =>
      {"fullName": fullName, "profilePhoto": profilePhoto, "_id": id};
}
