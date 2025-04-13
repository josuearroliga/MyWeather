import 'package:flutter/material.dart';
import 'package:my_weather/infrastructure/datasources/weather_datasource_impl.dart';
import 'package:my_weather/presentation/screens/HomeScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Homescreen(datasource: WeatherDatasourceImpl());
  }
}
