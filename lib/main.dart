import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:aurinko/widgets/widgets.dart';
import 'package:aurinko/repositories/repositories.dart';
import 'package:aurinko/api/api.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurinko',
      home: Weather(
        weatherRepository: weatherRepository,
      ),
    );
  }
}
