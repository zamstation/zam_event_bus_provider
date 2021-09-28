import 'package:zam_core/exception.dart';

///
/// An exception that is thrown when no EventBusProvider
/// is found in the widget tree.
///
class EventBusProviderNotFoundException extends NamedException {
  @override
  get problem => 'EventBusProvider not found.';
  @override
  get solution =>
      'Make sure you have added EventBusProvider to the root of the widget tree.';
  @override
  get severity => ExceptionSeverity.critical;

  const EventBusProviderNotFoundException();
}
