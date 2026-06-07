import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../data/model/character_model/character_model.dart';
import '../../data/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this._characterRepository)
      : super(const CharacterInitialState());
  final CharacterRepository _characterRepository;


  int currentPage = 1;
  List<CharacterModel> allCharactersList = [
  ]; // المخزن الكبير اللي بنجمع فيه كل الصفحات
  bool isPageLoading = false; // to prevent multiple requests at the same time.

  //// 👈 1. المخازن الجديدة اللي هتشيل حالة الفلترة الحالية جوه الكيوبت
  String? currentName;
  String? currentStatus;
  String? currentSpecies;
  String? currentType;
  String? currentGender;


  Future<void> getCharactersFunction({bool isFilter = false,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    //1- if we reached the end of the pagination (all characters loaded) and the user is not doing filtering,
    // don't send another request to the api because there is no more data to load.
    if (state is CharacterLoadedState &&
        (state as CharacterLoadedState).hasReachedMax && !isFilter) return;

    //2- to prevent multiple requests at the same time like pagination (except for the filtering it allows its request).
    //if user pressed on filtering button while the page is still loading, we allow the filtering request to be sent.
    if (isPageLoading && !isFilter) return;

    //3- at filtering, we reset the page number and the big list to start fresh with the new filter results.
    if (isFilter) {
      currentPage = 1;
      allCharactersList.clear();
      isPageLoading = false;

      currentName = name;
      currentStatus = status;
      currentSpecies = species;
      currentType = type;
      currentGender = gender;
    }

    //4- to prevent multiple request at the same time (especially for pagination)
    isPageLoading = true;

    //5- loading status according to page number (1 => first page loading, more than 1 => pagination loading)
    if (currentPage == 1) {
      emit(const CharacterFirstPageLoadingState());
    } else {
      emit(CharacterPaginationLoadingState(
          oldCharacters: List.from(allCharactersList)));
    }

    // 6- repository calling (taking the current page number).
    final result = await _characterRepository.getCharacters(page: currentPage,
      name: currentName,
      status: currentStatus,
      species: currentSpecies,
      type: currentType,
      gender: currentGender,
    );

    // 7- handling success and failure cases using dartZ package (fold method).
    result.fold(
          (failure) {
        // failure case
        isPageLoading = false;
        emit(CharacterFailureState(errorMessage: failure.message));
      },
          (responseModel) {
        // success case
        isPageLoading = false;

        // taking the new characters from the response
        final newCharacters = responseModel.results;

        // is it the last page or not (comparing with the pages in api)
        final bool hasReachedMax = currentPage >= responseModel.info.pages;

        //adding the new characters to the big storage list (allCharactersList)
        allCharactersList.addAll(newCharacters);

        // if we reached the end of pagination we can increase the page number for the next request,
        // and if we didn't don't increase it to prevent sending another request to api.
        if (!hasReachedMax) {
          currentPage++;
        }

        // sending success state to the screen with the big list of characters (allCharactersList).
        emit(CharacterLoadedState(characters: List.from(allCharactersList),
          hasReachedMax: hasReachedMax,));
      },
    );
  }
}
