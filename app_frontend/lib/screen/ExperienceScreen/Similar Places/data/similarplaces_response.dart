import '../../../Place_DetailedScreen/data/Place_Detailedscreen_response.dart';

class SimilarPlaceResponse {
  List<Place_DetailedResponse> similarplace;
  SimilarPlaceResponse({required this.similarplace});
  factory SimilarPlaceResponse.fromJson(List<dynamic> json) {
    print(json);
    return SimilarPlaceResponse(
      similarplace: List<Place_DetailedResponse>.from(
          json.map((x) => Place_DetailedResponse.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "": List<dynamic>.from(similarplace.map((x) => x.toJson())),
      };
}
