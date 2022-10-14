import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// Contains information about the current media.
  ///
  /// For example, the [MediaQueryData.size] property contains the width and
  /// height of the current window.
  MediaQueryData get query {
    return MediaQuery.of(this);
  }

  /// Returns the [FocusScopeNode] of the [FocusScope] that most tightly
  /// encloses the given [context].
  FocusScopeNode get focus {
    return FocusScope.of(this);
  }

  /// The data from the closest [Theme] instance that encloses the given
  /// context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// return Text(
  ///   "Hello World!",
  ///   style: context.theme.textTheme.headline6,
  /// );
  /// ```
  ThemeData get theme {
    return Theme.of(this);
  }

  /// The state from the closest instance of this class that encloses the given
  /// context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// context.navigator
  ///   ..pop()
  ///   ..pop()
  ///   ..pushNamed('/settings');
  /// ```
  ///

  /// The state from the furthest instance of instance of this class that encloses the given
  /// context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// context.navigator.pop();
  /// ```
  ///
  /// Consider using FluxNavigate if rootNavigator is needed.
  NavigatorState get navigator {
    return Navigator.of(this);
  }
}
