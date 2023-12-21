import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../feature/domain/entities/person_entity.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 166,
            height: 166,
            child: Image.network(person.image),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.colorWhite,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: person.status == 'Alive'
                            ? AppColors.colorGreen
                            : person.status == 'Dead'
                                ? AppColors.colorRed
                                : AppColors.colorYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${person.status} - ${person.species}',
                        style: const TextStyle(color: AppColors.colorWhite),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Last known location:',
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  person.location.name,
                  style: const TextStyle(
                    color: AppColors.colorWhite,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Origin:',
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  person.origin.name,
                  style: const TextStyle(
                    color: AppColors.colorWhite,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
