import 'dart:convert';

import 'package:intl/intl.dart';

import '../../domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
    required super.episode,
    required super.url,
    required super.created,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: LocationEntity(
        json['origin']['name'],
        json['origin']['url'],
      ),
      location: LocationEntity(
        json['location']['name'],
        json['location']['url'],
      ),
      image: json['image'],
      episode: json['episode'].cast<String>(),
      url: json['url'],
      created: DateTime.parse(json['created']),
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
      'origin': json.encode(origin.toJson()),
      'location': json.encode(location.toJson()),
      'image': image,
      'episode': episode.toString(),
      'url': url,
      'created': DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(created),
    };
  }
}
