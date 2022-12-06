import 'package:dd_study_22_ui/ui/roots/account.dart';
import 'package:dd_study_22_ui/ui/roots/app.dart';
import 'package:dd_study_22_ui/ui/roots/auth.dart';
import 'package:dd_study_22_ui/ui/roots/loader.dart';
import 'package:flutter/material.dart';

class NavigationRoutes {
  static const loaderWidget = "/";
  static const auth = "/auth";
  static const app = "/app";
  static const account = "/account";
}

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();

  static Future toLoader() async {
    return key.currentState?.pushNamedAndRemoveUntil(
        NavigationRoutes.loaderWidget, ((route) => false));
  }

  static void toAuth() {
    key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.auth, ((route) => false));
  }

  static void toHome() {
    key.currentState
        ?.pushNamedAndRemoveUntil(NavigationRoutes.app, ((route) => false));
  }

  static void toAccountProfile() {
    key.currentState?.pushNamed(NavigationRoutes.account);
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loaderWidget:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => LoaderWidget.create()));
      case NavigationRoutes.auth:
        return PageRouteBuilder(pageBuilder: ((_, __, ___) => Auth.create()));
      case NavigationRoutes.app:
        return PageRouteBuilder(pageBuilder: ((_, __, ___) => App.create()));
      case NavigationRoutes.account:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => Account.create()));
    }
    return null;
  }
}
