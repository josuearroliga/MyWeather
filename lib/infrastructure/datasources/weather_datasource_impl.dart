import 'package:dio/dio.dart';

import 'package:my_weather/domain/datasources/weather_datasource.dart';
import 'package:my_weather/domain/entitites/location_coordinates_entity.dart';
import 'package:my_weather/domain/entitites/weather_entity.dart';
import 'package:my_weather/infrastructure/models/location_coordinates_model.dart';
import 'package:my_weather/infrastructure/models/weather_model.dart';

class WeatherDatasourceImpl extends WeatherDatasource {
  final dio = Dio();
  final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  double longitude = 0;
  double latitude = 0;
  final String apiKey = 'f66410590e28bb77cb50435461f05352';

  @override
  Future<WeatherEntity> getWeather(String cityName) async {
    // TODO: implement getWeatherByCoordinates
    throw UnimplementedError();
  }

  @override
  Future<WeatherEntity> getWeatherByCoordinates(
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
      return WeatherEntity(
        id: weatherModel.id,
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

  @override
  Future<LocationCoordinatesEntity> getWeatherCoordinatesByApi(
    String cityNameSearch,
  ) async {
    final url =
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityNameSearch&limit=10&appid=$apiKey';
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      final coordsModel = LocationCoordinatesModel.fromMap(data);

      return LocationCoordinatesEntity(
        name: coordsModel.name,
        latitude: coordsModel.latitude,
        longitude: coordsModel.longitude,
        country: coordsModel.country,
      );
    } else {
      throw Exception('Failed to fetch weather data: ${response.statusCode}');
    }
  }
}
