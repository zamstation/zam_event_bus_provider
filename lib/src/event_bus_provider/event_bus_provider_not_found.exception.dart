import 'package:zam_core/exception.dart';

///
/// An exception that is thrown when no EventBusProvider
/// is found in the widget tree.
///
class EventBusProviderNotFoundException extends NamedException {
  get problem => 'EventBusProvider not found.';
  get solution =>
      'Make sure you have added EventBusProvider to the root of the widget tree.';
  get severity => ExceptionSeverity.critical;

  const EventBusProviderNotFoundException();
}
