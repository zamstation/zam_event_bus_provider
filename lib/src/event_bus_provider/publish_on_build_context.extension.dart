import 'package:flutter/material.dart';

import 'event_bus_on_build_context.extension.dart';

extension PublishOnBuildContextExtension on BuildContext {
  ///
  /// Publishes an event to EventBus.
  ///
  void publish<EVENT extends Object>(EVENT event) {
    bus.publish(event);
  }
}
