import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_weather/domain/entitites/weather.dart';
import 'package:my_weather/infrastructure/datasources/weather_datasource_impl.dart';
import 'package:my_weather/infrastructure/models/weather_model.dart';

class Homescreen extends StatefulWidget {
  final WeatherDatasourceImpl datasource;
  const Homescreen({super.key, required this.datasource});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Weather? _weather;
  bool _isLoading = true;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
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

    return await Geolocator.getCurrentPosition();
  }

  //Fetch weather after the permission for the location have been accepted.
  Future<void> _fetchWeather() async {
    try {
      // Determine the current position
      final position = await _determinePosition();

      // Fetch weather data using the position
      final weather = await widget.datasource.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      // Update the state with the fetched weather data
      setState(() {
        _weather = weather;
        _isLoading = false; // Stop loading once data is fetched
      });
    } catch (e) {
      // Handle errors (e.g., location or API errors)
      setState(() {
        _isLoading = false; // Stop loading even if an error occurs
      });
      print('Error fetching weather: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child:
              _isLoading
                  ? CircularProgressIndicator() // Show a loading spinner while fetching data
                  : _weather != null
                  ? GestureDetector(
                    onTap: () {
                      // Handle tap if needed
                    },
                    child: Text(
                      'City: ${_weather!.cityName}\n'
                      'Temperature: ${_weather!.currentTemperature}°C\n'
                      'Conditions: ${_weather!.conditions}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : Text(
                    'Failed to load weather data',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
        ),
      ),
    );
  }
}
