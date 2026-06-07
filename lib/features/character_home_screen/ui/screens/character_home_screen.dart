import 'dart:async';
import 'package:demo_project/core/constants/strings.dart';
import 'package:demo_project/features/character_home_screen/logic/character_cubit/character_cubit.dart';
import 'package:demo_project/features/character_home_screen/ui/widgets/search_bar_textField.dart';
import 'package:demo_project/features/character_home_screen/ui/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/routes.dart';
import '../widgets/character_card.dart';

// stateful widget because we need to listen to the scroll controller to implement pagination.
class CharacterHomeScreen extends StatefulWidget {
  const CharacterHomeScreen({super.key});

  @override
  State<CharacterHomeScreen> createState() => _CharacterHomeScreenState();
}

class _CharacterHomeScreenState extends State<CharacterHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce
        ?.cancel(); // to cancel any pending debounce timer when the widget is disposed, preventing memory leaks and unintended behavior.
    super.dispose();
  }

  void _onScroll() {
    final currentState = context
        .read<CharacterCubit>()
        .state;
    final double lockPosition = _scrollController.position.maxScrollExtent *
        0.8;

    // at loading a new page, we lock the scroll at 80% of the max scroll extent to prevent multiple requests.
    if (currentState is CharacterPaginationLoadingState &&
        _scrollController.position.pixels > lockPosition) {
      _scrollController.jumpTo(lockPosition);
      return;
    }

    // request new page (new cards)
    if (currentState is! CharacterPaginationLoadingState &&
        _scrollController.position.pixels >= lockPosition) {
      context.read<CharacterCubit>().getCharactersFunction();
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // to hide the keyboard when tapping outside the search bar
      child: Scaffold(
        backgroundColor: Colors.deepOrange[200],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130), //appbar height
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello', style: TextStyle(color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,),),
                SizedBox(height: 2),
                Text(
                  appUserName,
                  style: TextStyle(color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,),
                ),
              ],
            ),

            //user profile picture
            actions: [
              UserImage(imageUrl: 'https://i.pravatar.cc/150?img=33'),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchBarTextField(
                  onChanged: (query) {
                    // if there is an active timer from the previous character, cancel it immediately to reset the debounce delay.
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 350), () {
                      if (query
                          .trim()
                          .isEmpty) {
                        // if user cleared search field, we send null to reset the list to the original order.
                        context.read<CharacterCubit>().getCharactersFunction(
                          isFilter: true,
                          name: null,
                          status: null,
                          species: null,
                          type: null,
                          gender: null,
                        );
                      } else {
                        //if user is still typing, we send the search query to filter the list based on it,
                        // and we also reset the other filters to null to avoid any conflict with previous searches or filters.
                        context.read<CharacterCubit>().getCharactersFunction(
                          isFilter: true,
                          name: query,
                          status: null,
                          species: null,
                          type: null,
                          gender: null,
                        );
                      }
                    });
                  },
                  onFilterTap: () {
                    //open bottom sheet with the filters options
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.6,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24)),
                            ),
                            child: Center(child: Text(
                              'Filter Bottom Sheet Placeholder',
                              style: TextStyle(color: Colors.black45),)),
                          ),
                      //     FilterBottomSheet(
                      //   // بنباصي الفلاتر الحالية المتخزنة في الكيوبت عشان تظهر منورة كـ ديفولت أول ما يفتح
                      //   initialStatus: cubit.currentStatus,
                      //   initialGender: cubit.currentGender,
                      //   onApplyFilters: (status, gender) {
                      //     // 🚀 هنا مناداة الكيوبت العبقري بتاعك
                      //     cubit.getCharactersFunction(
                      //       isFilter: true, // بنقوله ده فلتر جديد صفر الـ list القديمة
                      //       name: cubit.currentName, // 👈 بنحافظ على كلمة البحث الحالية في السيرش بار لو موجودة
                      //       status: status,
                      //       gender: gender,
                      //     );
                      //   },
                      // ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        body: BlocConsumer<CharacterCubit, CharacterState>(
          listener: (context, state) {
            if (state is CharacterFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errorMessage}'),
                  backgroundColor: Colors.red,),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<CharacterCubit>();
            final characters = cubit.allCharactersList;
            // Check if first page loading
            final isFirstPageLoading = state is CharacterFirstPageLoadingState ||
                state is CharacterInitialState;
            //Check if loading a new card (Pagination)
            final isPaginationLoading = state is CharacterPaginationLoadingState;

            if (!isFirstPageLoading && characters.isEmpty) {
              return const Center(
                child: Text(
                  'No characters found 😢',
                  style: TextStyle(color: Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Skeletonizer(
                    enabled: isFirstPageLoading,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      controller: _scrollController,
                      itemCount: isFirstPageLoading ? 6 : characters.length +
                          (isPaginationLoading ? 2 : 0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      // Prepare items (cashing) before they appear on screen for smooth scrolling and image loading.
                      cacheExtent: 500,
                      itemBuilder: (context, index) {
                        //1- loading state for the first page: show skeletons and don't try to build the real cards
                        if (isFirstPageLoading) {
                          return const CharacterCard(
                            name: 'Loading Character Name',
                            status: 'Alive',
                            species: 'Human',
                            gender: 'Male',
                          );
                        }
                        //at pagination loading state, the last 2 items will be skeletons, and the rest will be real character cards.
                        if (index >= characters.length) {
                          return const Skeletonizer(
                            enabled: true,
                            child: CharacterCard(
                              name: 'Loading More...',
                              status: 'Alive',
                              species: 'Alien',
                              gender: 'Female',
                            ),
                          );
                        }
                        final character = characters[index];
                        return GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(
                                context,
                                Routes.characterDetailsScreen,
                                arguments: character,
                              ),
                          child: CharacterCard(
                            image: character.image,
                            name: character.name,
                            species: character.species,
                            status: character.status,
                            type: character.type,
                            gender: character.gender,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
