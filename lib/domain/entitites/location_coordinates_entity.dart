class LocationCoordinatesEntity {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String? state; // Optional field

  const LocationCoordinatesEntity({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    this.state,
  });
}
