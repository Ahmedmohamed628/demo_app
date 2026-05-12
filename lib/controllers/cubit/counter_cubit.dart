import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';

// part 'counter_state.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  //1st function
  void increment() {
    emit(state + 1);
  }

  //2nd function
  void decrement() {
    emit(state - 1);
  }
}

//import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'counter_state.dart';
//
// class CounterCubit extends Cubit<CounterState> {
//   CounterCubit() : super(CounterInitial());
//
//   //1st function
//   void increment() {
//     emit(CounterUpdate(state.count + 1));
//   }
//
//   //2nd function
//   void decrement() {
//     emit(CounterUpdate(state.count - 1));
//   }
// }
