import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_i_morty/core/constants.dart';
import 'package:rick_i_morty/core/error/failure.dart';

import '../../../domain/entities/person_entity.dart';
import '../../../domain/usecases/get_all_persons.dart';
import '../../../../feature/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) return;
    final currentState = state;
    List<PersonEntity> oldPerson = <PersonEntity>[];

    if (currentState is PersonLoaded) {
      oldPerson = currentState.personList;
    }

    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
      (failure) => PersonError(message: _mapFailureToMessage(failure)),
      (character) {
        page++;
        final persons = (state as PersonLoading).oldPersonList;
        persons.addAll(character);
        emit(PersonLoaded(persons));
      },
    );
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure _:
        return CACHED_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
