import 'package:equatable/equatable.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';

class SearchCategory extends Equatable {
  final int id;
  final String name;
  final String activeIcon;
  final String dactiveIcon;
  bool selected;
  final SearchType searchCategory;

  SearchCategory(
      {required this.searchCategory,
      required this.id,
      required this.name,
      required this.activeIcon,
      required this.dactiveIcon,
      required this.selected});

  @override
  List<Object?> get props => [id, name, selected, searchCategory];
}
