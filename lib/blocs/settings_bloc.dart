import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

enum TemperatureUnits {
  fahrenheit,
  celsius,
}

class SettingsState extends Equatable {
  final TemperatureUnits temperatureUnits;

  SettingsState({@required this.temperatureUnits})
      : assert(temperatureUnits != null),
        super([temperatureUnits]);
}

abstract class SettingsEvent extends Equatable {}

class TemperatureUnitsToggled extends SettingsEvent {}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState =>
      SettingsState(temperatureUnits: TemperatureUnits.celsius);

  @override
  Stream<SettingsState> mapEventToState(
      SettingsState currentState, SettingsEvent event) async* {
    if (event is TemperatureUnitsToggled) {
      yield SettingsState(
          temperatureUnits:
              currentState.temperatureUnits == TemperatureUnits.celsius
                  ? TemperatureUnits.fahrenheit
                  : TemperatureUnits.celsius);
    }
  }
}
