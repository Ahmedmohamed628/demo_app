import 'package:demo_project/app_bloc_observer.dart';
import 'package:demo_project/controllers/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // setup for hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getTemporaryDirectory()).path),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              //for counter A
              BlocSelector<CounterCubit, CounterState, int>(
                selector: (state) => state.countA,
                builder: (context, counterAState) {
                  return Text(
                    'counter A: ${counterAState.toString()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              //for counter B
              BlocSelector<CounterCubit, CounterState, int>(
                selector: (state) => state.countB,
                builder: (context, counterBState) {
                  return Text(
                    'counter B : ${counterBState.toString()}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  );
                },
              ),
            ],
          ),
        ),

        floatingActionButton: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Counter A'),
                    FloatingActionButton(
                      onPressed: () =>
                          context.read<CounterCubit>().incrementA(),
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: () =>
                          context.read<CounterCubit>().decrementA(),
                      tooltip: 'decrement',
                      child: const Icon(Icons.minimize),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Counter B'),
                    FloatingActionButton(
                      onPressed: () =>
                          context.read<CounterCubit>().incrementB(),
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: () =>
                          context.read<CounterCubit>().decrementB(),
                      tooltip: 'decrement',
                      child: const Icon(Icons.minimize),
                    ),
                  ],
                ),
              ],
            );
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
