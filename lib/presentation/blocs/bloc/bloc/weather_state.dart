// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherLoadInProgress extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  const WeatherLoadSuccess({required this.weather});
  @override
  List<Object> get props => [weather];
}

final class WeatherLoadFailure extends WeatherState {
  final String message;

  const WeatherLoadFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class WeatherOperationInProgress extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherOperationFailure extends WeatherState {
  final String error;

  const WeatherOperationFailure({required this.error});
  @override
  List<Object> get props => [error];
}

final class WeatherOperationSuccess extends WeatherState {
  final String message;

  const WeatherOperationSuccess({required this.message});
  @override
  List<Object> get props => [message];
}
