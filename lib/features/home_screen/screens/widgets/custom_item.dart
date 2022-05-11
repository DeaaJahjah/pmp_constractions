import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/features/home_screen/models/search_category.dart';

class CustomItem extends StatelessWidget {
  final SearchCategory searchCategory;
  final Function() onTap;

  const CustomItem(
      {Key? key, required this.onTap, required this.searchCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: (searchCategory.selected) ? orange : darkBlue,
            border: Border.all(
                color: (searchCategory.selected) ? darkBlue : orange,
                width: 2.5),
            borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (searchCategory.searchCategory != SearchType.all)
              Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  (searchCategory.selected)
                      ? searchCategory.activeIcon
                      : searchCategory.dactiveIcon,
                ),
              ),
            Text(
              searchCategory.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
