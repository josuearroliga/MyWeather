part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object> get props => [];
}

final class WeatherStarted extends WeatherEvent {
  @override
  List<Object> get props => [];
}

final class WeatherRequested extends WeatherEvent {
  final String cityName;

  const WeatherRequested(this.cityName);
}

final class WeatherByCoordinatesRequested extends WeatherEvent {
  final double latitude;
  final double longitude;

  const WeatherByCoordinatesRequested(this.latitude, this.longitude);
}
