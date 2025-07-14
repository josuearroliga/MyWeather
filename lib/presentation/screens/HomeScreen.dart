// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/config/iconSelector.dart';
import 'package:my_weather/domain/entitites/weather.dart';
import 'package:my_weather/infrastructure/datasources/weather_datasource_impl.dart';
import 'package:my_weather/presentation/blocs/bloc/bloc/weather_bloc.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            switch (state) {
              case WeatherInitial():
                return SizedBox();
              case WeatherLoadInProgress():
                return Center(
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              case WeatherLoadSuccess():
                return Center(child: _ShowWeather(state.weather));
              case WeatherLoadFailure():
                return Center(child: Text("The weather couldn't be fetched"));
              case WeatherOperationInProgress():
                return Center(
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              case WeatherOperationFailure():
                return Center(child: Text("The weather couldn't be fetched"));
              case WeatherOperationSuccess():
                // TODO: Handle this case.
                throw UnimplementedError();
            }
          },
        ),
      ),
    );
  }
}

class _ShowWeather extends StatelessWidget {
  final Weather weather;
  const _ShowWeather(this.weather);

  @override
  Widget build(BuildContext context) {
    final icon = iconSelector[weather.id]!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
          height: 200,
          width: 200,
          child: Image.asset(icon, fit: BoxFit.fill),
        ),
        SizedBox(height: 20),
        Text(
          "${double.parse(weather.currentTemperature).round()}°C",
          style: TextTheme.of(context).displayLarge,
        ),
        SizedBox(height: 10),
        Text(
          "${weather.conditions}".toUpperCase(),
          style: TextTheme.of(context).titleLarge,
        ),
      ],
    );
  }
}
