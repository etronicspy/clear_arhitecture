import 'package:rick_i_morty/feature/domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) {}

  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) {}


}
