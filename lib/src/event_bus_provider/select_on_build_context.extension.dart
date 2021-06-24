import 'package:flutter/material.dart';

import 'event_bus_on_build_context.extension.dart';

extension SelectOnBuildContextExtension on BuildContext {
  /// 
  /// Selects ViewModel from EventBus.
  /// 
  Stream<VIEW_MODEL> select<VIEW_MODEL extends Object>() {
    return this.bus.select<VIEW_MODEL>();
  }
}
