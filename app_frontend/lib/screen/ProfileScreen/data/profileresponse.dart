class ProfileResponse {
  String id;
  String fullName;
  String phoneNumber;
  String email;
  String userRole;
  bool isVerified;
  String verifyOtp;
  bool isActive;
  List<String> bookMarks;
  List<String> following;
  List<String> followers;
  int followingCount;
  int followersCount;
  String profilePhoto;
  List<String> posts;
  String createdAt;
  String updatedAt;
  int v;
  ProfileResponse(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.userRole,
      required this.isVerified,
      required this.profilePhoto,
      required this.bookMarks,
      required this.createdAt,
      required this.followers,
      required this.followersCount,
      required this.following,
      required this.followingCount,
      required this.isActive,
      required this.posts,
      required this.updatedAt,
      required this.v,
      required this.verifyOtp});
  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
          id: json["_id"],
          fullName: json["fullName"],
          phoneNumber: json["phoneNumber"],
          email: json["email"],
          userRole: json["userRole"],
          isVerified: json["isVerified"],
          profilePhoto: json["profilePhoto"],
          createdAt: json["createdAt"],
          followers: json["followers"],
          followersCount: json["followersCount"],
          following: json["following"],
          followingCount: json["followingCount"],
          isActive: json["isActive"],
          posts: json["posts"],
          updatedAt: json["updatedAt"],
          verifyOtp: json["verifyOtp"],
          v: json["__v"],
          bookMarks: ["bookMarks"]);
  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "userRole": userRole,
        "isVerified": isVerified,
        "profilePhoto": profilePhoto,
        "createdAt": createdAt,
        "followers": followers,
        "followersCount": followersCount,
        "following": following,
        "followingCount": followingCount,
        "isActive": isActive,
        "posts": posts,
        "updatedAt": updatedAt,
        "verifyOtp": verifyOtp,
        "__v": v
      };
}
