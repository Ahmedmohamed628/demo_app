import 'package:demo_project/core/constants/routes.dart';
import 'package:demo_project/features/character_home_screen/ui/screens/character_home_screen.dart';
import 'package:flutter/material.dart';

import 'features/character_home_screen/ui/screens/character_details_screen.dart';

class AppRouters {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.characterHomeScreen:
        return MaterialPageRoute(builder: (_) => const CharacterHomeScreen());

      case Routes.characterDetailsScreen:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
    }
  }
}
