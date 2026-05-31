// //(الـ Data Source اللي بتستخدم الـ Dio الجاهز لعمل الـ Calls).
// import 'package:dio/dio.dart';
// import '../../../core/network/api_constants.dart';
// import '../../../core/network/dio_client.dart';
// import '../../../core/network/error_handler.dart';
//
// class CharacterApiService {
//   // 1. بنجيب نسخة الـ Dio المتظبطة والوحيدة من المصنع فوراً
//   final Dio _dio = DioClient.getDio();
//
//   // Future<List<dynamic>> getAllCharacters() async {
//   //   try {
//   //     final response = await _dio.get(ApiConstants.character);
//   //     return response.data['results']; // بترجع الداتا الخام
//   //   } catch (error) {
//   //     // بنبعت الإيرور للمستشفى تترجمه، وبعدين بنرميه (throw) للـ Repository
//   //     throw ApiErrorHandler.handle(error);
//   //   }
//   // }
//   //
//   //
//   // // todo : in pagination case =>
//   // Future<Map<String, dynamic>> getCharactersData({required int page}) async {
//   //   try {
//   //     // بنباصي رقم الصفحة كـ Query Parameter في الـ URL
//   //     final response = await _dio.get(ApiConstants.character, queryParameters: {'page': page});
//   //     return response.data; // هنا هنرجع الـ Map الكبيرة كاملة (جواها info و results)
//   //   } catch (error) {
//   //     throw ApiErrorHandler.handle(error);
//   //   }
//   // }
//
//
//
//   // todo: in case we want to get single character by ID (path parameter for id) =>
//
//   Future<Map<String, dynamic>> getSingleCharacter({required int id}) async {
//     try {
//       final response = await _dio.get(
//         '${ApiConstants.character}/$id',    //  هنا Path Parameter (الـ ID اتلزق في الرابط)
//       );
//       return response.data;
//     } catch (error) {
//       throw ApiErrorHandler.handle(error);
//     }
//   }
//
//
//   //todo: in case we want to search for characters by name / status / type /gender (filtering & get data & pagination) =>
//   //  الفنكشن دي بتغنيني عن ال 2 اللي فوق بتوع ال getAllCharacters و ال getCharacterData علشان هنا بيتعمل pagination و get لل data + كمان ال filtering .
//   Future<Map<String, dynamic>> getCharactersData({
//     required int page,         // ده إجباري علشان الـ Pagination
//     String? name,
//     String? status,
//     String? species,
//     String? type,
//     String? gender,
//   }) async {
//     try {
//       final response = await _dio.get(
//         ApiConstants.character,
//         // الـ Dio ذكي جداً: لو أي Key قيمته null، بيمسحه أوتوماتيك ومبيبعتوش للسيرفر
//         //query parameters for filtering and pagination =>
//         queryParameters: {
//           'page': page, 'name': name, 'status': status, 'species': species, 'type': type, 'gender': gender,
//         },
//       );
//       return response.data;
//     } catch (error) {
//       throw ApiErrorHandler.handle(error);
//     }
//   }
//
//
// }
//
