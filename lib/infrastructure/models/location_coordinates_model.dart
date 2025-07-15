// ignore_for_file: public_member_api_docs, sort_constructors_first

class LocationCoordinatesModel {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String? state; // Optional field

  const LocationCoordinatesModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'state': state,
    };
  }

  factory LocationCoordinatesModel.fromMap(Map<String, dynamic> map) {
    return LocationCoordinatesModel(
      name: map['name'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      country: map['country'] as String,
      state: map['state'] != null ? map['state'] as String : null,
    );
  }
}
