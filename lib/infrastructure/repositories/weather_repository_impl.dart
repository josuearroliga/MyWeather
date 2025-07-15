import 'package:dartz/dartz.dart';
import 'package:my_weather/core/errors/failure.dart';
import 'package:my_weather/domain/datasources/weather_datasource.dart';
import 'package:my_weather/domain/entitites/location_coordinates_entity.dart';
import 'package:my_weather/domain/entitites/weather_entity.dart';
import 'package:my_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  //Declaring the datasource
  final WeatherDatasource _weatherDatasource;

  WeatherRepositoryImpl({required WeatherDatasource weatherDatasource})
    : _weatherDatasource = weatherDatasource;
  @override
  Future<WeatherEntity> getWeather(String cityName) async {
    return await _weatherDatasource.getWeather(cityName);
  }

  @override
  Future<WeatherEntity> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    return await _weatherDatasource.getWeatherByCoordinates(
      latitude,
      longitude,
    );
  }

  @override
  Future<Either<Failure, LocationCoordinatesEntity>> getWeatherCoordinatesByApi(
    String cityNameSearch,
  ) async {
    try {
      final result = await _weatherDatasource.getWeatherCoordinatesByApi(
        cityNameSearch,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
