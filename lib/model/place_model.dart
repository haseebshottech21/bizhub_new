class PlacesModel {
  final String description;
  final String placeId;
  PlacesModel({
    required this.description,
    required this.placeId,
  });

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
