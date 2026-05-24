//1st method
part of 'counter_cubit.dart';

class CounterState extends Equatable {
  const CounterState({required this.countA, required this.countB});

  final int countA;
  final int countB;

  CounterState copyWith({int? countA, int? countB}) {
    return CounterState(
      countA: countA ?? this.countA,
      countB: countB ?? this.countB,
    );
  }

  @override
  List<Object?> get props => [countA, countB];
}

//2nd method
// part of 'counter_cubit.dart';
//
// @immutable
// //todo: if i have (2 counters) in 1 state file
// sealed class CounterState {
//   const CounterState(this.countA , this.countB);
//
//   final int countA;
//   final int countB;
// }
//
// final class CounterInitial extends CounterState {
//   const CounterInitial() : super(0,0);
// }
//
// final class CounterUpdate extends CounterState {
//   const CounterUpdate(super.countA, super.countB);
// }

//todo: if i have 1 state (1 counter)
//part of 'counter_cubit.dart';
//
// @immutable
// sealed class CounterState {
//   const CounterState(this.count);
//
//   final int count;
// }
//
// final class CounterInitial extends CounterState {
//   const CounterInitial() : super(0);
// }
//
// final class CounterUpdate extends CounterState {
//   const CounterUpdate(super.count);
// }