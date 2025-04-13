import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_weather/config/geolocator.dart';
import 'package:my_weather/domain/datasources/weather_datasource.dart';
import 'package:my_weather/domain/entitites/weather.dart';
import 'package:my_weather/infrastructure/models/weather_model.dart';

class WeatherDatasourceImpl extends WeatherDatasource {
  final dio = Dio();
  final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  double longitude = 0;
  double latitude = 0;
  final String apiKey = 'f66410590e28bb77cb50435461f05352';

  @override
  Future<Weather> getWeather(String cityName) async {
    // TODO: implement getWeatherByCoordinates
    throw UnimplementedError();
  }

  @override
  Future<Weather> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    final url =
        '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data;

      // Use WeatherModel to parse the response
      final weatherModel = WeatherModel.fromMap(data);

      // Return a Weather entity
      return Weather(
        cityName: weatherModel.cityName,
        currentTemperature: weatherModel.currentTemperature,
        conditions: weatherModel.conditions,
        sunrise: weatherModel.sunrise,
        sunset: weatherModel.sunset,
      );
    } else {
      throw Exception('Failed to fetch weather data: ${response.statusCode}');
    }
  }
}
