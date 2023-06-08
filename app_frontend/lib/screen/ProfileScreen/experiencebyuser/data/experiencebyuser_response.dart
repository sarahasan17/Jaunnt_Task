import '../../../ExperienceScreen/data/experiencescreen_response.dart';

class ExperienceByUserResponse {
  List<ExperienceResponse> response;
  ExperienceByUserResponse({required this.response});
  factory ExperienceByUserResponse.fromJson(List<dynamic> json) => ExperienceByUserResponse(
      response: List<ExperienceResponse>.from(
          json.map((x) => ExperienceResponse.fromJson(x))));
  Map<String, dynamic> toJson() => {
    "": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}
