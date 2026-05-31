import 'package:demo_project/features/character_home_screen/logic/character_cubit/character_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterHomeScreen extends StatelessWidget {
  const CharacterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Character Home Screen'), centerTitle: true),
      body: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          switch (state) {
            case CharacterInitial():
              return const Center(child: CircularProgressIndicator());
            case CharacterLoaded():
              return GridView.builder(
                // itemCount: state.productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  // final character = state.productList[index];
                },
              );
            case CharacterFailure():
              return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
