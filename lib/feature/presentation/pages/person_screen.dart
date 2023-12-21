import 'package:flutter/material.dart';
import 'package:rick_i_morty/common/app_colors.dart';

import 'person_list_widget.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.colorWhite,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const PersonList(),
    );
  }
}
