import 'package:dartz/dartz.dart';
import 'package:rick_i_morty/core/error/exception.dart';
import 'package:rick_i_morty/core/platform/network_info.dart';

import '../../../core/error/failure.dart';
import '../../domain/entities/person_entity.dart';
import '../../domain/repositories/person_repository.dart';
import '../datasources/person_local_data_source.dart';
import '../datasources/person_remote_data_source.dart';
import '../models/person_model.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() async {
      return await remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() async {
      return await remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonEntity>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
