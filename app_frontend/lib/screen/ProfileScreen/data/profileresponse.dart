class ProfileResponse {
  String id;
  String fullName;
  String phoneNumber;
  String email;
  String userRole;
  bool isVerified;
  bool isActive;
  List<String> friends;
  List<String> bookMarks;
  String profilePhoto;
  List<String> posts;
  String createdAt;
  String updatedAt;
  int v;
  ProfileResponse({
    required this.friends,
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.userRole,
    required this.isVerified,
    required this.profilePhoto,
    required this.bookMarks,
    required this.createdAt,
    required this.isActive,
    required this.posts,
    required this.updatedAt,
    required this.v,
  });
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return ProfileResponse(
      id: json["_id"],
      fullName: json["fullName"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      userRole: json["userRole"],
      isVerified: json["isVerified"],
      profilePhoto: json["profilePhoto"],
      createdAt: json["createdAt"],
      friends:
          List<String>.from(json["friends"].map((x) => x.toString())) ?? ["ok"],
      isActive: json["isActive"],
      posts:
          List<String>.from(json["posts"].map((x) => x.toString())) ?? ["ok"],
      updatedAt: json["updatedAt"],
      v: json["__v"] ?? "account exists",
      bookMarks:
          List<String>.from(json["bookmarks"].map((x) => x.toString())) ??
              ["ok"],
    );
  }

  Map<String, dynamic> toJson() => {
        "bookmarks": List<String>.from(bookMarks.map((x) => x.toString())),
        "_id": id,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "userRole": userRole,
        "isVerified": isVerified,
        "profilePhoto": profilePhoto,
        "createdAt": createdAt,
        "friends": List<String>.from(friends.map((x) => x.toString())),
        "isActive": isActive,
        "posts": List<String>.from(posts.map((x) => x.toString())),
        "updatedAt": updatedAt,
        "__v": v
      };
}
