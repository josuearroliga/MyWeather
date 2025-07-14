import 'package:dartz/dartz.dart';
import 'package:my_weather/core/errors/failure.dart';
import 'package:my_weather/domain/entitites/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String cityName);
  Future<Weather> getWeatherByCoordinates(double latitude, double longitude);
  Future<Either<Failure, List<String>>> getWeatherCoordinatesByApi(
    String cityNameSearch,
  );
}
