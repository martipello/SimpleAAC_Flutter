import 'package:flutter/material.dart';
import '../ui/shared_widgets/simple_aac_dialog.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<bool?> pop() async {
    final currentState = navigatorKey.currentState;
    if (currentState?.mounted == true) {
      currentState?.pop();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  bool isSameRoute(String newRouteName) {
    final currentState = navigatorKey.currentState;
    var isNewRouteSameAsCurrent = false;
    if (currentState != null) {
      currentState.popUntil(
        (route) {
          if (route.settings.name == newRouteName) {
            isNewRouteSameAsCurrent = true;
          }
          return true;
        },
      );
    }
    return isNewRouteSameAsCurrent;
  }

  Future<bool?> navigateTo(
    String routeName, {
    dynamic arguments,
  }) async {
    final currentState = navigatorKey.currentState;
    if (currentState != null) {
      return currentState.pushNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return Future.value(false);
    }
  }

  Future<bool?> showDialog(
    Widget child,
  ) async {
    final currentState = navigatorKey.currentState;
    if (currentState != null) {
      return child.show(currentState.context);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> pushReplacementNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    final currentState = navigatorKey.currentState;
    if (currentState != null) {
      await currentState.pushReplacementNamed(routeName, arguments: arguments);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
