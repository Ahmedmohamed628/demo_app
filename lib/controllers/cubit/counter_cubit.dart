//todo => 1st method
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

//todo: if i have (2 counters) in 1 cubit file
class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super(CounterState(countA: 0, countB: 0));

  //1st function for counter A
  void incrementA() {
    emit(state.copyWith(countA: state.countA + 1));
  }

  //2nd function for counter A
  void decrementA() {
    emit(state.copyWith(countA: state.countA - 1));
  }

  //1st function for counter B
  void incrementB() {
    emit(state.copyWith(countB: state.countB + 1));
  }

  //2nd function for counter B
  void decrementB() {
    emit(state.copyWith(countB: state.countB - 1));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState(countA: json['countA'], countB: json['countB']);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return {
      'countA': state.countA,
      'countB': state.countB,
    };
  }
}


//todo=> 2nd method
// import 'package:equatable/equatable.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'counter_state.dart';
// //todo: if i have (2 counters) in 1 cubit file
// class CounterCubit extends HydratedCubit<CounterState> {
//   CounterCubit() : super(CounterInitial());
//
//   //1st function for counter A
//   void incrementA() {
//     emit(CounterUpdate(state.countA + 1, state.countB));
//   }
//
//   //2nd function for counter A
//   void decrementA() {
//     emit(CounterUpdate(state.countA - 1, state.countB));
//   }
//
//   //1st function for counter B
//   void incrementB() {
//     emit(CounterUpdate(state.countA, state.countB + 1));
//   }
//
//   //2nd function for counter B
//   void decrementB() {
//     emit(CounterUpdate(state.countA, state.countB - 1));
//   }
//
//   @override
//   CounterState? fromJson(Map<String, dynamic> json) {
//     return CounterUpdate(json['countA'], json['countB']);
//   }
//
//   @override
//   Map<String, dynamic>? toJson(CounterState state) {
//     return {
//       'countA': state.countA,
//       'countB': state.countB,
//     };
//   }
// }


// todo: if i have (1 counter) in 1 cubit file
//// import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:meta/meta.dart';
// //
// // // part 'counter_state.dart';
// //
// // class CounterCubit extends Cubit<int> {
// //   CounterCubit() : super(0);
// //
// //   //1st function
// //   void increment() {
// //     emit(state + 1);
// //   }
// //
// //   //2nd function
// //   void decrement() {
// //     emit(state - 1);
// //   }
// // }
//
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'counter_state.dart';
//
// class CounterCubit extends HydratedCubit<CounterState> {
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
//
//   @override
//   CounterState? fromJson(Map<String, dynamic> json) {
//     return CounterUpdate(json['count']);
//   }
//
//   @override
//   Map<String, dynamic>? toJson(CounterState state) {
//     return {
//       'count': state.count,
//     };
//   }
// }