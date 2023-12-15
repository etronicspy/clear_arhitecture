import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_i_morty/core/error/exception.dart';
import '../models/person_model.dart';

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);

  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    return await _getPersonFromUrlByParams('?page=$page');
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) async {
    return await _getPersonFromUrlByParams('?name=$query');
  }

  Future<List<PersonModel>> _getPersonFromUrlByParams(String params) async {
    final http.Response response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character/$params'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
