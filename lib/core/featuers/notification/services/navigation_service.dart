import 'package:flutter/material.dart';

class NavigationService {
  Future<dynamic> navigateTo({required String? routeName}) {
    print('route name $routeName');
    return GlobalVariable.navState.currentState!.pushNamed(routeName!);
  }
}

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}
