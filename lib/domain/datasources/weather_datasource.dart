import 'package:my_weather/domain/entitites/location_coordinates_entity.dart';
import 'package:my_weather/domain/entitites/weather_entity.dart';

abstract class WeatherDatasource {
  Future<WeatherEntity> getWeather(String cityName);
  Future<WeatherEntity> getWeatherByCoordinates(
    double latitude,
    double longitude,
  );
  Future<LocationCoordinatesEntity> getWeatherCoordinatesByApi(
    String cityNameSearch,
  );
}
