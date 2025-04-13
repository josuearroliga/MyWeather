class WeatherModel {
  final String cityName;
  final String currentTemperature;
  final String conditions;
  final DateTime sunrise;
  final DateTime sunset;

  //TODO: Adjust model and add more fields for what we received from the API
  WeatherModel({
    required this.cityName,
    required this.currentTemperature,
    required this.conditions,
    required this.sunrise,
    required this.sunset,
  });

  // Convert a Map to a Weather object
  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    try {
      return WeatherModel(
        cityName: map['name'] as String, // City name
        currentTemperature:
            map['main']['temp'].toString(), // Current temperature
        conditions:
            (map['weather'] as List).first['description']
                as String, // Weather description
        sunrise: DateTime.fromMillisecondsSinceEpoch(
          map['sys']['sunrise'] * 1000,
        ), // Sunrise time
        sunset: DateTime.fromMillisecondsSinceEpoch(
          map['sys']['sunset'] * 1000,
        ), // Sunset time
      );
    } catch (e) {
      throw Exception('Error parsing WeatherModel: $e');
    }
  }

  // Convert a Weather object to a Map
  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'currentTemperature': currentTemperature,
      'conditions': conditions,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
    };
  }
}
