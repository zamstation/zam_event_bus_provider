import 'package:flutter/material.dart';

import 'event_bus_on_build_context.extension.dart';

extension SaveOnBuildContextExtension on BuildContext {
  ///
  /// Saves an object to store.
  ///
  void save(Object message) {
    bus.save(message);
  }
}
