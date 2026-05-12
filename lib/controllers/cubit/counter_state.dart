part of 'counter_cubit.dart';

@immutable
sealed class CounterState {
  const CounterState(this.count);

  final int count;
}

final class CounterInitial extends CounterState {
  const CounterInitial() : super(0);
}

final class CounterUpdate extends CounterState {
  const CounterUpdate(super.count);
}
