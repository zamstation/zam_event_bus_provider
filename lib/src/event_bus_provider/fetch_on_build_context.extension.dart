import 'package:flutter/material.dart';

import 'event_bus_on_build_context.extension.dart';

extension FetchOnBuildContextExtension on BuildContext {
  /// 
  /// Fetches data from store.
  /// 
  VIEW_MODEL fetch<VIEW_MODEL extends Object>() {
    return this.bus.selectFromStore<VIEW_MODEL>();
  }
}
