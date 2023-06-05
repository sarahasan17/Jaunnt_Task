class ExperienceOfPlaceResponse {
  List<ExperienceOfPlaceResponse2> experienceOfPlaceResponse;
  ExperienceOfPlaceResponse({required this.experienceOfPlaceResponse});
  factory ExperienceOfPlaceResponse.fromJson(Map<String, dynamic> json) =>
      ExperienceOfPlaceResponse(
          experienceOfPlaceResponse: List<ExperienceOfPlaceResponse2>.from(
        json[""].map((x) => ExperienceOfPlaceResponse2.fromJson(x)),
      ));
  Map<String, dynamic> toJson() => {
        "": List<dynamic>.from(
            experienceOfPlaceResponse.map((x) => x.toJson())),
      };
}

class ExperienceOfPlaceResponse2 {
  String sId;
  String postedBy;
  String discription;
  List<String> tags;

  ExperienceOfPlaceResponse2(
      {required this.sId,
      required this.postedBy,
      required this.discription,
      required this.tags});

  factory ExperienceOfPlaceResponse2.fromJson(Map<String, dynamic> json) =>
      ExperienceOfPlaceResponse2(
        sId: json['_id'],
        postedBy: json['postedBy'],
        discription: json['discription'],
        tags: json['tags'].cast<String>(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['postedBy'] = this.postedBy;
    data['discription'] = this.discription;
    data['tags'] = this.tags;
    return data;
  }
}
