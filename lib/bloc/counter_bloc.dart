import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Events
abstract class CounterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class ToggleTheme extends CounterEvent {}

// States
class CounterState extends Equatable {
  final int counter;
  final ThemeData themeData;

  CounterState(this.counter, this.themeData);

  @override
  List<Object> get props => [counter, themeData];
}

// BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc()
      : super(CounterState(0, ThemeData.light())) {
    on<Increment>((event, emit) {
      emit(CounterState(state.counter + 1, state.themeData));
    });

    on<Decrement>((event, emit) {
      emit(CounterState(state.counter - 1, state.themeData));
    });

    on<ToggleTheme>((event, emit) {
      final newTheme = state.themeData.brightness == Brightness.light
          ? ThemeData.dark()
          : ThemeData.light();
      emit(CounterState(state.counter, newTheme));
    });
  }
}