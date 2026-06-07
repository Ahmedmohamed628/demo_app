part of 'character_cubit.dart';

@immutable
sealed class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object?> get props => [];
}

// for cubit creation (the default state of the screen before any action happens).
final class CharacterInitialState extends CharacterState {
  const CharacterInitialState();
}


// loading phase for the first time (after try again button, or when the screen opens for the first time or new filter).
final class CharacterFirstPageLoadingState extends CharacterState {
  const CharacterFirstPageLoadingState();
}

final class CharacterLoadedState extends CharacterState {
  final List<CharacterModel> characters; // empty list for ui
  final bool hasReachedMax; // have we reached the end of the pagination or not (to stop hitting the api when we reach the end)
  const CharacterLoadedState(
      {required this.characters, required this.hasReachedMax});

  @override
  List<Object?> get props => [characters, hasReachedMax];
}


// the screen shows the old list of characters, and at the same time a small spinner at the bottom for pagination loading state
// loading phase for the next pages (page 2,3, etc..)
final class CharacterPaginationLoadingState extends CharacterState {
  final List<
      CharacterModel> oldCharacters; // keep showing old list while loading the new page
  const CharacterPaginationLoadingState({required this.oldCharacters});

  @override
  List<Object?> get props => [oldCharacters];
}

final class CharacterFailureState extends CharacterState {
  final String errorMessage;

  const CharacterFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
