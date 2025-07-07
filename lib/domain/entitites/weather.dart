class Weather {
  final int id;
  final String cityName;
  final String currentTemperature;
  final String conditions;
  final DateTime sunrise;
  final DateTime sunset;

  Weather({
    required this.id,
    required this.cityName,
    required this.currentTemperature,
    required this.conditions,
    required this.sunrise,
    required this.sunset,
  });

  Weather copyWith({
    int? id,
    String? cityName,
    String? currentTemperature,
    String? conditions,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return Weather(
      id: id ?? this.id,
      cityName: cityName ?? this.cityName,
      currentTemperature: currentTemperature ?? this.currentTemperature,
      conditions: conditions ?? this.conditions,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}
