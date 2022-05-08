import 'package:flutter/cupertino.dart';
import 'package:pmpconstractions/core/config/enums/enums.dart';

class SearchProvider extends ChangeNotifier {
  SearchType searchType = SearchType.all;

  void searchState(SearchType newSearchType) async {
    searchType = newSearchType;
    NotificationListener;
  }
}
