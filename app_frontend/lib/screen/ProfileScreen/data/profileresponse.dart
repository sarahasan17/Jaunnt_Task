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
      {this.id,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.userRole,
      this.isVerified,
      this.profilePhoto,
      this.bookMarks,
      this.createdAt,
      this.followers,
      this.followersCount,
      this.following,
      this.followingCount,
      this.isActive,
      this.posts,
      this.updatedAt,
      this.v,
      this.verifyOtp});
  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
      id: json["_id"],
      fullName: json["fullName"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      userRole: json["userRole"],
      isVerified: json["isVerified"],
      profilePhoto: json["profilePhoto"],
      /**bookMarks: List<String>.from(
              json["bookMarks"].map((x) => String.fromJson(x))),**/
      createdAt: json["createdAt"],
      followers: json["followers"],
      followersCount: json["followersCount"],
      following: json["following"],
      followingCount: json["followingCount"],
      isActive: json["isActive"],
      posts: json["posts"],
      updatedAt: json["updatedAt"],
      verifyOtp: json["verifyOtp"],
      v: json["__v"]);
  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "userRole": userRole,
        "isVerified": isVerified,
        "profilePhoto": profilePhoto,
        /**"bookMarks": List<dynamic>.from(bookMarks.map((x) => x.toJson())),**/
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
