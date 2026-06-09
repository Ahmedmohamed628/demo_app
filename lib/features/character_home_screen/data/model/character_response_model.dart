import 'info_model.dart';
import 'character_model.dart';

class CharacterResponseModel {
  //{
  //   "info": {
  //     "count": 826,
  //     "pages": 42,
  //     "next": "https://rickandmortyapi.com/api/character/?page=2",
  //     "prev": null
  //   },

  //todo: character model
  //   "results": [
  //     {
  //       "id": 1,
  //       "name": "Rick Sanchez",
  //       "status": "Alive",
  //       "species": "Human",
  //       "type": "",
  //       "gender": "Male",
  //       "origin": {
  //         "name": "Earth",
  //         "url": "https://rickandmortyapi.com/api/location/1"
  //       },
  //       "location": {
  //         "name": "Earth",
  //         "url": "https://rickandmortyapi.com/api/location/20"
  //       },
  //       "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
  //       "episode": [
  //         "https://rickandmortyapi.com/api/episode/1",
  //         "https://rickandmortyapi.com/api/episode/2",
  //         // ...
  //       ],
  //       "url": "https://rickandmortyapi.com/api/character/1",
  //       "created": "2017-11-04T18:48:46.250Z"
  //     },
  //     // ...
  //   ]
  // }
  final List<CharacterModel> results;
  final InfoModel info;

  CharacterResponseModel({required this.results, required this.info});

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      results:
          json['results'] != null
              ? (json['results'] as List)
                  .map((e) => CharacterModel.fromJson(e))
                  .toList()
              : [],
      info: InfoModel.fromJson(json['info'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((result) => result.toJson()).toList(),
      'info': info.toJson(),
    };
  }
}
