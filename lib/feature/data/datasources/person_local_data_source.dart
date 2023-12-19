import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exception.dart';
import '../../../core/constants.dart';
import '../models/person_model.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}


class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonList = sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonList!.isNotEmpty) {
      return Future.value(jsonPersonList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonList);
    return Future.value(jsonPersonList);
  }
}
