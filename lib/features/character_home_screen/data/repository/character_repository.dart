import 'package:dartz/dartz.dart';
import 'package:demo_project/core/errors/failure.dart';
import '../../../../core/network/error_handler.dart';
import '../character_api_service_modified.dart';
import '../model/character_response_model.dart';

class CharacterRepository {
  final CharacterApiServiceModified _characterApiServiceModified;

  // 1. بنباصي الـ Service في الكونستركتور (Dependency Injection)
  CharacterRepository(this._characterApiServiceModified);


  //todo: get & filtering data with pagination case (using dartz package for error handling) =>

  Future<Either<Failure, CharacterResponseModel>> getCharacters({
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
        type: type,);

      // 2. بنباصي الـ rawJson علطول للـ factory بتاعك وهو هيقوم بالواجب كله
      final CharacterResponseModel responseModel = CharacterResponseModel
          .fromJson(rawJson);

      return Right(responseModel);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(const ServerFailure(
          "Failed to process character data, parsing error."));
    }
  }


//todo: in case no use of dartz
// Future<CharacterResponseModel> getCharacters({
//   required int page,
//   String? name,
//   String? status,
//   String? species,
//   String? type,
//   String? gender,
// }) async {
//   try {
//     // 1. بنجيب الـ Map الكبيرة من الـ Service بناءً على رقم الصفحة
//     final Map<String, dynamic> rawJson = await _characterApiServiceModified.getCharactersData(
//       page: page, name: name, gender: gender, species: species, status: status, type: type,);
//
//     // 2. بنباصي الـ rawJson علطول للـ factory بتاعك وهو هيقوم بالواجب كله
//     final CharacterResponseModel responseModel = CharacterResponseModel.fromJson(rawJson);
//
//     return responseModel;
//   } on ApiError catch (e) {
//     throw ApiError(message: e.message);
//   } catch (e) {
//     throw ApiError(
//       message: "Failed to process character data, parsing error.",
//     );
//   }
// }





}


