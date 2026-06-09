import 'package:demo_project/core/constants/routes.dart';
import 'package:demo_project/core/network/api_service.dart';
import 'package:demo_project/features/character_home_screen/logic/character_cubit/character_cubit.dart';
import 'package:demo_project/features/character_home_screen/ui/screens/character_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/character_home_screen/data/character_api_service_modified.dart';
import 'features/character_home_screen/data/model/character_model.dart';
import 'features/character_home_screen/data/repository/character_repository.dart';
import 'features/character_home_screen/ui/screens/character_details_screen.dart';

class AppRouters {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
    //root route or home screen route (/)
      case '/':
      case Routes.characterHomeScreen:
      return MaterialPageRoute(builder: (_) =>
          BlocProvider(
            create: (context) =>
            CharacterCubit(
              CharacterRepository(CharacterApiServiceModified(ApiService())),
            )
              ..getCharactersFunction(),
              child: const CharacterHomeScreen(),
            ));

      case Routes.characterDetailsScreen:
      // 👈 بنستقبل الـ arguments ونعمل لها cast للموديل بتاعنا
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character: character));

      default:
      //in case no route found, return this screen to avoid app crash
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(child: Text('No route defined for this path')),),
        );

    }
  }
}
