import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'character_details_state.dart';

class CharacterDetailsCubit extends Cubit<CharacterDetailsState> {
  CharacterDetailsCubit() : super(CharacterDetailsInitial());
}
