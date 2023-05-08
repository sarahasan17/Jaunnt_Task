class AddExperienceRequest {
  String placeId;
  String location;
  String description;
  String travelMode;
  List<String> category;
  List<String> tags;
  int groupSize;
  String tripTime;
  String dateOfTrip;
  AddExperienceRequest(
      {this.placeId,
      this.location,
      this.description,
      this.travelMode,
      this.category,
      this.tags,
      this.groupSize,
      this.tripTime,
      this.dateOfTrip});
  factory AddExperienceRequest.fromJson(Map<String, dynamic> json) =>
      AddExperienceRequest(
          placeId: json["placeId"],
          location: json["location"],
          description: json["description"],
          travelMode: json["travelMode"],
          category: json["category"],
          tags: json["tags"],
          groupSize: json["groupSize"],
          tripTime: json["tripTime"],
          dateOfTrip: json["dateOfTrip"]);
  Map<String, dynamic> toJson() => {
        "placeId": placeId,
        "location": location,
        "description": description,
        "travelMode": travelMode,
        "category": category,
        "tags": tags,
        "groupSize": groupSize,
        "tripTime": tripTime,
        "dateOfTrip": dateOfTrip
      };
}