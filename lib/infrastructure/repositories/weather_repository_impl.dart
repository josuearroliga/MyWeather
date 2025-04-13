import 'package:my_weather/domain/datasources/weather_datasource.dart';
import 'package:my_weather/domain/entitites/weather.dart';
import 'package:my_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  //Declaring the datasource
  final WeatherDatasource _weatherDatasource;

  WeatherRepositoryImpl({required WeatherDatasource weatherDatasource})
    : _weatherDatasource = weatherDatasource;
  @override
  Future<Weather> getWeather(String cityName) async {
    return await _weatherDatasource.getWeather(cityName);
  }

  @override
  Future<Weather> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    return await _weatherDatasource.getWeatherByCoordinates(
      latitude,
      longitude,
    );
  }
}
