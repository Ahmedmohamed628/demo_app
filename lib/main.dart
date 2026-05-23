import 'package:demo_project/controllers/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      debugShowCheckedModeBanner: false,
      title: 'Todo Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Todo Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(title),
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final controllerBLoc = context.read<TaskBloc>();
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          labelText: 'Add task'
                      ),
                    ),

                    ElevatedButton(onPressed: () {
                      if (controller.text.isEmpty) return;
                      controllerBLoc.add(AddTaskEvent(title: controller.text));
                      controller.clear();
                    }, child: Text('Add')),

                    SizedBox(height: 15,),

                    Expanded(
                      child: ListView.builder(
                        itemCount: state.tasksList.length,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, index) {
                          return ListTile(
                            shape: OutlineInputBorder(),
                            tileColor: Colors.black54,
                            title: Text(state.tasksList[index].title,
                              style: TextStyle(color: Colors.white),),
                            leading: Checkbox(
                              activeColor: Colors.green,
                              value: state.tasksList[index].isCompleted,
                              onChanged: (value) =>
                                  controllerBLoc.add(ToggleTaskEvent(
                                      id: state.tasksList[index].id)),
                            ),
                            trailing: IconButton(onPressed: () =>
                                controllerBLoc.add(RemoveTaskEvent(
                                    id: state.tasksList[index].id)),
                                icon: Icon(Icons.delete, color: Colors.red,)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
