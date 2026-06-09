import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../data/model/character_model.dart';
import '../../data/repository/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this._characterRepository)
      : super(const CharacterInitialState()) {
    // Listening to live network changes (WiFi / Mobile Data / None).
    // فتح الرادار المستمع لتغيرات الشبكة لحظة بلحظة.
    // 📡 بنراقب النت أول ما الكيوبت يتخلق
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
        List<ConnectivityResult> results) {
      // If internet returns, and we were locked on error, and we have loaded old data.
      // لو النت رجع، وإحنا كنا قافلين الحنفية بسبب إيرور سابق، والشاشة فيها داتا قديمة أصلاً.
      // لو النت رجع (WiFi أو موبايل داتا) وإحنا كنا واقفين على إيرور وفي منطقة الـ Pagination
      //هل لستة الشبكات الحالية(result) فيها إن النت قاطع؟ لو النت قاطع بترجع true لو مش قاطع (فيه wifi/data) بترجع false
      // is internet lost? true if no wifi or mobile data, false if there is wifi or mobile data
      //todo: old condition for auto request after internet returns (pagination case only)
      // if (!results.contains(ConnectivityResult.none) && isNetworkErrorLocked && allCharactersList.isNotEmpty) {
      //   isNetworkErrorLocked = false; // Unlock the safety flag (افتح قفل الأمان)
      //   getCharactersFunction(); // Auto-request the next page immediately (اطلب الصفحة الجديدة فوراً أوتوماتيك)
      // }

      //todo: new condition for auto request after internet returns (pagination case or first page error case)
      // 1. الحارس الأول: تأكيد إن النت رجع فعلاً
      // if (!results.contains(ConnectivityResult.none)) {
      //
      //   // 2. الشرط المركب: إما كنا في نص الـ Pagination والقفل مقفول، أو ده أول فتح للأبلكيشن واللستة فاضية خالص والـ state واقفة على إيرور
      //   if ((isNetworkErrorLocked && allCharactersList.isNotEmpty) || (allCharactersList.isEmpty && state is CharacterFailureState)) {
      //
      //     isNetworkErrorLocked = false; // Unlock the safety flag
      //     getCharactersFunction(); // Auto-request the next page or the first page immediately
      //   }
      // }

      // 1. الحارس السريع: لو مفيش نت.. اخرج فوراً ومتكملش قراءة!
      if (results.contains(ConnectivityResult.none)) return;

      // 2. طالما عدى من الحارس اللي فوق، يبقى أكيد فيه نت.. شيك بقا على الـ States براحتك في سطر واحد
      if ((isNetworkErrorLocked && allCharactersList.isNotEmpty) ||
          (allCharactersList.isEmpty && state is CharacterFailureState)) {
        isNetworkErrorLocked = false; // Unlock the safety flag
        getCharactersFunction(); // Auto-request the next page or the first page immediately
      }
    });
  }

  // --- CLEAN UP (تنظيف الميموري) ---
  @override
  Future<void> close() {
    // Cancel connectivity subscription to prevent memory leaks.
    // قفل ماسورة المراقبة فوراً عند تدمير الكيوبت لحماية بطارية ورام الموبايل.
    _connectivitySubscription?.cancel(); // 🛑 حماية من الـ Memory Leak
    return super.close();
  }


  // Instance from connectivity package to check network status.
  // كائن من الباكيدج عشان نقدر نسأل الموبايل عن حالة الشبكة.
  final CharacterRepository _characterRepository;

  // Subscription to hold the live network stream and listen to changes.
  // ماسورة الاشتراك اللي ماسكة البث المباشر للنت عشان نفضل مستمعين لتغييراته.
  final Connectivity _connectivity = Connectivity();

  // Safety flag: if true, blocks scroll listener from sending redundant requests during errors.
  // مفتاح الأمان: لو قيمته صح، بيقفل حنفية السكرول ومبيخليهوش يبعت ريكويستات تانية والنت قاطع.
  StreamSubscription? _connectivitySubscription;

  bool isNetworkErrorLocked = false;
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

    // todo: 🔒 لو الحنفية مقفولة بسبب إيرور نت سابق، اخرج فوراً
    if (isNetworkErrorLocked && !isFilter) return;

    //3- at filtering, we reset the page number and the big list to start fresh with the new filter results.
    if (isFilter) {
      currentPage = 1;
      allCharactersList.clear();
      isPageLoading = false;
      isNetworkErrorLocked = false; // صفر القفل عند الفلترة :todo

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
        // 🔒 الريكويست فشل؟ اقفل الحنفية عشان الـ Scroll المزعج ميبعتش تاني todo
        isNetworkErrorLocked = true;
        emit(CharacterFailureState(errorMessage: failure.message));
      },
          (responseModel) {
        // success case
        isPageLoading = false;
        isNetworkErrorLocked = false; // 👍 نجح؟ افتح الحنفية للمرة الجاية: todo
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
