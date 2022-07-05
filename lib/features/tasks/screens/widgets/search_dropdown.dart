import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/loc.dart';
import 'package:pmpconstractions/features/home_screen/models/project.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';

class SearchDropDown extends StatelessWidget {
  final List<MemberRole> members;
  final void Function(MemberRole?)? onChanged;
  final MemberRole? selectedItem;
  const SearchDropDown(
      {Key? key,
      required this.members,
      required this.selectedItem,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<MemberRole>(
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(),
      ),
      items: members,
      // dropdownBuilder: buildItemDropdown,
      dropdownButtonProps: const DropdownButtonProps(
        color: orange,
      ),

      popupProps: PopupProps.bottomSheet(
        bottomSheetProps: const BottomSheetProps(
          backgroundColor: Color.fromARGB(255, 8, 22, 42),
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          padding: const EdgeInsets.all(10),
          decoration: InputDecoration(
            hintText: context.loc.search,
            border: InputBorder.none,
          ),
        ),
        itemBuilder: buildItemDropdown,
        emptyBuilder: (context, w) {
          return Center(child: Text(context.loc.no_resualt));
        },
        errorBuilder: (context, w, b) {
          return Center(child: Text(context.loc.no_resualt));
        },
      ),
      itemAsString: (member) {
        return member.memberName;
      },
      selectedItem: selectedItem,
      onChanged: onChanged,

      // (member) {
      //   selectedItem = member!;
      // },
    );
  }
}

Widget buildItemDropdown(BuildContext context, MemberRole item, bo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: orange,
          child: CircleAvatar(
              radius: 19,
              child: CashedImage(
                imageUrl: item.profilePicUrl!,
                radius: 19,
                size: 40,
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.memberName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}
