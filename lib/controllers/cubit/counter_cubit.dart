// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:meta/meta.dart';
//
// // part 'counter_state.dart';
//
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
//
//   //1st function
//   void increment() {
//     emit(state + 1);
//   }
//
//   //2nd function
//   void decrement() {
//     emit(state - 1);
//   }
// }

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  //1st function
  void increment() {
    emit(CounterUpdate(state.count + 1));
  }

  //2nd function
  void decrement() {
    emit(CounterUpdate(state.count - 1));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterUpdate(json['count']);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return {
      'count': state.count,
    };
  }
}
