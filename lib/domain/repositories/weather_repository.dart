import 'package:my_weather/domain/entitites/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String cityName);
  Future<Weather> getWeatherByCoordinates(double latitude, double longitude);
}
