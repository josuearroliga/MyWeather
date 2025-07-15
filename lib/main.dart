import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/infrastructure/datasources/weather_datasource_impl.dart';
import 'package:my_weather/infrastructure/repositories/weather_repository_impl.dart';
import 'package:my_weather/presentation/blocs/bloc/bloc/weather_bloc.dart';
import 'package:my_weather/presentation/screens/HomeScreen.dart';

Future main() async {
  final WeatherDatasourceImpl weatherDataSource = WeatherDatasourceImpl();

  final WeatherRepositoryImpl weatherRepository = WeatherRepositoryImpl(
    weatherDatasource: weatherDataSource,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (_) => WeatherBloc(weatherRepository: weatherRepository),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Homescreen();
  }
}
