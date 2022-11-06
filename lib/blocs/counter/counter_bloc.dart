import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> with HydratedMixin {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementCounterEvent>(_incrementCounter);
  }

  void _incrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) => state.toMap();
}
