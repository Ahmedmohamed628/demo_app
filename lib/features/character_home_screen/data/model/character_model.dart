import 'location_model.dart';

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationModel location;
  final LocationModel origin;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.location,
    required this.origin,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      species: json['species'] ?? 'Unknown',
      type: json['type'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      location:
          json['location'] != null
              ? LocationModel.fromJson(json['location'])
              : LocationModel(name: 'Unknown', url: ''),
      origin:
          json['origin'] != null
              ? LocationModel.fromJson(json['origin'])
              : LocationModel(name: 'Unknown', url: ''),
      image: json['image'] ?? '',
      episode:
          json['episode'] != null ? List<String>.from(json['episode']) : [],
      url: json['url'] ?? '',
      created: json['created'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'location': location.toJson(),
      'origin': origin.toJson(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }
}
