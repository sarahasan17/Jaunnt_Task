import 'package:app_frontend/screen/Place_DetailedScreen/data/Place_Detailedscreen_response.dart';

class BookmarkedPlaceResponse {
  List<Place_DetailedResponse> response;
  BookmarkedPlaceResponse({required this.response});
  factory BookmarkedPlaceResponse.fromJson(List<dynamic> json) {
    print(json);
    return BookmarkedPlaceResponse(
      response: List<Place_DetailedResponse>.from(
          json.map((x) => Place_DetailedResponse.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}
