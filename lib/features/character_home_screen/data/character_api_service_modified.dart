//todo: modified (characterApiService) to use the general ApiService instead of dio directly, and remove try-catch because the general ApiService is already handling it and throwing ApiError
import '../../../core/network/api_constants.dart';
import '../../../core/network/api_service.dart';

class CharacterApiServiceModified {
  final ApiService _apiService;

  // Dependency Injection
  CharacterApiServiceModified(this._apiService);

  Future<Map<String, dynamic>> getCharactersData({
    required int page,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    // مفيش try-catch هنا! لأن الـ ApiService العام شايلها وبيقذف الـ ApiError أوتوماتيك
    final responseData = await _apiService.get(
      endPoint: ApiConstants.character,
      queryParameters: {
        'page': page,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
      },
    );

    return responseData as Map<String, dynamic>;
  }

  // Single Character
  Future<Map<String, dynamic>> getSingleCharacter({required int id}) async {
    final responseData = await _apiService.get(
      endPoint: '${ApiConstants.character}/$id',
    );
    return responseData as Map<String, dynamic>;
  }
}
