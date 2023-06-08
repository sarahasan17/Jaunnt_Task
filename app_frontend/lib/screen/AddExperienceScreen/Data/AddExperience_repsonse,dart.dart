class AddExperienceResponse {
  String success;
  String error;
  AddExperienceResponse({required this.success, required this.error});
  factory AddExperienceResponse.fromJson(Map<String, dynamic> json) =>
      AddExperienceResponse(success: json["success"], error: json["error"]);
  Map<String, dynamic> toJson() => {"success": success, "error": error};
}
