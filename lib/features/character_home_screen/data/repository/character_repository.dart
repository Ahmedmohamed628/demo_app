import '../../../../core/network/error_handler.dart';
import '../character_api_service_modified.dart';
import '../model/character_model/character_response_model.dart';

class CharacterRepository {
  final CharacterApiServiceModified _characterApiServiceModified;

  // 1. بنباصي الـ Service في الكونستركتور (Dependency Injection)
  CharacterRepository(this._characterApiServiceModified);

  // //without pagination =>
  // Future<List<CharacterModel>> fetchCharacters() async {
  //   try {
  //     // بنادي على الـ Service تجيب الداتا الخام (List of Maps)
  //     final List<dynamic> charactersData = await _characterApiService.getAllCharacters();
  //
  //     // 3. الـ Parsing: بنحول الـ Maps لـ Objects من الـ CharacterModel بتاعنا
  //     final List<CharacterModel> charactersList = charactersData.map((jsonMap) => CharacterModel.fromJson(jsonMap)).toList();
  //
  //     return charactersList;
  //
  //   } on ApiError catch (e) {
  //     // 4. لو الـ Service رمت ApiError صريح (زي ما شرحنا في أول ملف) بنلقطه هنا ونعيده للـ Cubit
  //     throw ApiError(message: e.message);
  //
  //   } catch (e) {
  //     // 5. حماية إضافية لو حصلت مشكلة في الـ Parsing نفسه (اسم متغير غلط في الموديل مثلاً)
  //     throw ApiError(message: "Failed to process character data, parsing error.");
  //   }
  // }
  //
  //
  //
  //
  // //todo: in pagination case =>
  // Future<CharacterResponseModel> getCharacters({required int pages,}) async {
  //   try {
  //     // 1. بنجيب الـ Map الكبيرة من الـ Service بناءً على رقم الصفحة
  //     final Map<String, dynamic> rawJson = await _characterApiService.getCharactersData(pages: pages);
  //
  //     // 2. بنباصي الـ rawJson علطول للـ factory بتاعك وهو هيقوم بالواجب كله
  //     final CharacterResponseModel responseModel = CharacterResponseModel.fromJson(rawJson);
  //
  //     return responseModel;
  //
  //   } on ApiError catch (e) {
  //     throw ApiError(message: e.message);
  //   } catch (e) {
  //     throw ApiError(message: "Failed to process character data, parsing error.");
  //   }
  // }

  //todo: get & filtering data with pagination case =>

  Future<CharacterResponseModel> getCharacters({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    try {
      // 1. بنجيب الـ Map الكبيرة من الـ Service بناءً على رقم الصفحة
      final Map<String, dynamic> rawJson = await _characterApiServiceModified
          .getCharactersData(
            page: page,
            name: name,
            gender: gender,
            species: species,
            status: status,
            type: type,
          );

      // 2. بنباصي الـ rawJson علطول للـ factory بتاعك وهو هيقوم بالواجب كله
      final CharacterResponseModel responseModel =
          CharacterResponseModel.fromJson(rawJson);

      return responseModel;
    } on ApiError catch (e) {
      throw ApiError(message: e.message);
    } catch (e) {
      throw ApiError(
        message: "Failed to process character data, parsing error.",
      );
    }
  }
}
