import 'package:flutter/material.dart';
import 'package:zam_event_bus/zam_event_bus.dart';

import 'event_bus.provider.dart';

extension EventBusOnBuildContextExtension on BuildContext {
  ///
  /// EventBus that can dispatch, select, save and fetch data.
  ///
  EventBus get bus => EventBusProvider.of(this);
}
