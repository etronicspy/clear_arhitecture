import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'feature/presentation/pages/person_screen_widget.dart';
import 'common/app_colors.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) => sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(
            create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.colorWhite,
          colorScheme: const ColorScheme(
            background: AppColors.errorColor,
            brightness: Brightness.dark,
            primary: AppColors.errorColor,
            onPrimary: AppColors.errorColor,
            secondary: AppColors.errorColor,
            onSecondary: AppColors.greyColor,
            error: AppColors.errorColor,
            onError: AppColors.colorBlack,
            onBackground: AppColors.errorColor,
            surface: AppColors.greyColor,
            onSurface: AppColors.colorBlack,
          ),
        ),
        home: const PersonScreen(),
      ),
    );
  }
}
