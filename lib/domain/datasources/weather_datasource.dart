import 'package:my_weather/domain/entitites/weather.dart';

abstract class WeatherDatasource {
  Future<Weather> getWeather(String cityName);
  Future<Weather> getWeatherByCoordinates(double latitude, double longitude);
}
