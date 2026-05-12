import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<IncrementEvent>((event, emit) {
      emit(CounterUpdate(state.count + 1));
    });
    on<DecrementEvent>((event, emit) {
      emit(CounterUpdate(state.count - 1));
    });
  }
}
