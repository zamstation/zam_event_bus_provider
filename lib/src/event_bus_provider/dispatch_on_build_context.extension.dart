import 'package:flutter/material.dart';

import 'event_bus_on_build_context.extension.dart';

extension DispatchOnBuildContextExtension on BuildContext {
  ///
  /// Publishes an event to EventBus.
  ///
  void dispatch<EVENT extends Object>(EVENT event) {
    this.bus.publish(event);
  }
}
