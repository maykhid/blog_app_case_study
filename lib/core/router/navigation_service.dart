import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  dynamic pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToRoute(Widget route) {
    return _navigationKey.currentState!.push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => route,
      ),
    );
  }

  Future<bool> maybePop() {
    return _navigationKey.currentState!.maybePop();
  }
}
