# Event Bus Provider

A flutter provider that passes EventBus down to all the widgets.  
  
[![Version](https://img.shields.io/pub/v/zam_event_bus_provider?color=%234287f5)](https://pub.dev/packages/zam_event_bus_provider)
[![Build](https://github.com/zamstation/zam_event_bus_provider/actions/workflows/build.yaml/badge.svg)](https://github.com/zamstation/zam_event_bus_provider/actions/workflows/build.yaml)
[![Stars](https://img.shields.io/github/stars/zamstation/zam_event_bus_provider.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/zamstation/zam_event_bus_provider/stargazers)
[![License](https://img.shields.io/github/license/zamstation/zam_event_bus_provider)](https://pub.dev/packages/zam_event_bus_provider/license)

## What's inside the package

Includes the following core components.

  * [EventBusProvider](https://pub.dev/documentation/zam_event_bus_provider/latest/zam_event_bus_provider/EventBusProvider-class.html)

Check out all the components in detail [here](https://pub.dev/documentation/zam_event_bus_provider/latest/zam_event_bus_provider/zam_event_bus_provider-library.html)

## How to use

```dart
void main() {
  final bus = EventBus(transformers);

  // Add EventBusProvider before MaterialApp so that
  // it is made available to all the routes.
  final app = EventBusProvider(
    bus: bus,
    child: MaterialApp(
      home: MyHomePage(title: 'Event Bus Demo'),
    ),
  );
  runApp(app);
}
```

To learn more, move on to the [example section](https://pub.dev/packages/zam_event_bus_provider/example) or check out this dedicated [example in github](https://github.com/zamstation/zam_event_bus_provider/blob/main/example/lib/main.dart).

## Contributors
  * [Amsakanna](https://github.com/amsakanna)
