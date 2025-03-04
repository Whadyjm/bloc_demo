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

class AddProduct extends CounterEvent {
  final String product;

  AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProduct extends CounterEvent {
  final String product;

  RemoveProduct(this.product);

  @override
  List<Object> get props => [product];
}

// States
class CounterState extends Equatable {
  final int counter;
  final ThemeData themeData;
  final List<String> products;

  CounterState(this.counter, this.themeData, this.products);

  @override
  List<Object> get props => [counter, themeData, products];
}

// BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0, ThemeData.light(), [])) {
    on<Increment>((event, emit) {
      emit(CounterState(state.counter + 1, state.themeData, state.products));
    });

    on<Decrement>((event, emit) {
      emit(CounterState(state.counter - 1, state.themeData, state.products));
    });

    on<ToggleTheme>((event, emit) {
      final newTheme = state.themeData.brightness == Brightness.light
          ? ThemeData.dark()
          : ThemeData.light();
      emit(CounterState(state.counter, newTheme, state.products));
    });

    on<AddProduct>((event, emit) {
      final updatedProducts = List<String>.from(state.products)
        ..add(event.product);
      emit(CounterState(state.counter, state.themeData, updatedProducts));
    });

    on<RemoveProduct>((event, emit) {
      final updatedProducts = List<String>.from(state.products)
        ..remove(event.product);
      emit(CounterState(state.counter, state.themeData, updatedProducts));
    });
  }
}
