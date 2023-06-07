class ExperienceOfPlaceResponse {
  List<ExperienceOfPlaceResponse2> experienceOfPlaceResponse;
  ExperienceOfPlaceResponse({required this.experienceOfPlaceResponse});
  factory ExperienceOfPlaceResponse.fromJson(List<dynamic> json) =>
      ExperienceOfPlaceResponse(
          experienceOfPlaceResponse: List<ExperienceOfPlaceResponse2>.from(
        json.map((x) => ExperienceOfPlaceResponse2.fromJson(x)),
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
        discription: "amma",
        tags: List<String>.from(json["tags"].map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'postedBy': postedBy,
        'discription': discription,
        'tags': List<dynamic>.from(tags.map((x) => x.toString())),
      };
}
