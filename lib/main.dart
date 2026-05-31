import 'package:demo_project/app_routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(appRouters: AppRouters(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouters});

  final AppRouters appRouters;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.generateRoute,

    );
  }
}


