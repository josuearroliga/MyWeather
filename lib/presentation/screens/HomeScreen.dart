import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                return _ShowWeather();
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
  const _ShowWeather();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final weather = state is WeatherLoadSuccess ? state.weather : null;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/forecast/clear sky.png")),
            Text("${weather?.id}"),
          ],
        );
      },
    );
  }
}
