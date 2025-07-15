import 'package:dartz/dartz.dart';
import 'package:my_weather/core/errors/failure.dart';
import 'package:my_weather/domain/entitites/location_coordinates_entity.dart';
import 'package:my_weather/domain/entitites/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather(String cityName);
  Future<WeatherEntity> getWeatherByCoordinates(
    double latitude,
    double longitude,
  );
  Future<Either<Failure, LocationCoordinatesEntity>> getWeatherCoordinatesByApi(
    String cityNameSearch,
  );
}
