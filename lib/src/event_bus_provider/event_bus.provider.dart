import 'package:flutter/material.dart';
import 'package:zam_event_bus/zam_event_bus.dart';

import 'event_bus_provider_not_found.exception.dart';

///
/// Provides [EventBus] down the widget tree.
///
class EventBusProvider extends InheritedWidget {
  final EventBus bus;

  ///
  /// This static function can be used by widgets
  /// to fetch the [EventBus] from any location
  /// in the widget tree down from the point it is provided.
  ///
  static EventBus of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<EventBusProvider>();
    if (provider == null) throw EventBusProviderNotFoundException();
    return provider.bus;
  }

  ///
  /// Add EventBusProvider before MaterialApp so that
  /// it is made available to all the routes.
  ///
  const EventBusProvider({
    Key? key,
    required this.bus,
    required Widget child,
  }) : super(key: key, child: child);

  ///
  /// Rebuilds when the [EventBus] instance is changed.
  ///
  @override
  bool updateShouldNotify(EventBusProvider oldWidget) {
    return bus != oldWidget.bus;
  }
}
