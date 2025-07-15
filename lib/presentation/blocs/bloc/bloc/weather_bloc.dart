import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_weather/domain/entitites/location_coordinates_entity.dart';
import 'package:my_weather/domain/entitites/weather_entity.dart';
import 'package:my_weather/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc({required WeatherRepository weatherRepository})
    : _weatherRepository = weatherRepository,
      super(WeatherInitial()) {
    on<WeatherByCoordinatesRequested>(_onWeatherByCoordinatesRequested);
    on<WeatherByCoordinatesRequestedByAPI>(
      _onWeatherByCoordinatesRequestedToAPI,
    );
    on<WeatherStarted>(_onStarted);

    //
    add(WeatherStarted());
  }

  Future<void> _onStarted(
    WeatherStarted event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadInProgress());
    try {
      final position = await _determinePosition();

      final weather = await _weatherRepository.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      emit(WeatherLoadSuccess(weather: weather));
    } catch (e) {
      emit(WeatherLoadFailure(message: "$e"));
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  //Fetching the weather for the selected location
  Future<void> _onWeatherByCoordinatesRequested(
    WeatherByCoordinatesRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadInProgress());
    try {
      // Determine the current position
      final position = await _determinePosition();

      // Fetch weather data using the position
      final weather = await _weatherRepository.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      emit(WeatherLoadSuccess(weather: weather));
    } catch (e) {
      // Handle errors (e.g., location or API errors)
      emit(
        WeatherLoadFailure(
          message:
              'The coordinates could not be retrieved at this time due to error: $e',
        ),
      );
    }
    // Update the state with the fetched weather data
    // Stop loading once data is fetched
  }

  Future<void> _onWeatherByCoordinatesRequestedToAPI(
    WeatherByCoordinatesRequestedByAPI event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(WeatherOperationInProgress());
      final coords = _weatherRepository.getWeatherCoordinatesByApi(
        event.cityName,
      );
    } catch (e) {
      // Handle errors (e.g., location or API errors)
      emit(
        WeatherLoadFailure(
          message:
              'The coordinates could not be retrieved at this time due to error: $e',
        ),
      );
    }
  }
}
