import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../../domain/entities/person_entity.dart';
import '../bloc/person_list_cubit/person_list_cubit.dart';
import '../bloc/person_list_cubit/person_list_state.dart';

class PersonList extends StatelessWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    List<PersonEntity> persons = [];
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoaded) {
        persons = state.personList;
      }
      return ListView.separated(
        itemBuilder: (context, index) {
          return Text('${persons[index]}');
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: AppColors.colorWhite,
          );
        },
        itemCount: persons.length,
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
