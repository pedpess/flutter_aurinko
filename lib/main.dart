import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aurinko/widgets/widgets.dart';
import 'package:aurinko/blocs/blocs.dart';
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

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Aurinko',
            theme: themeState.theme,
            home: Weather(
              weatherRepository: widget.weatherRepository,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }
}
