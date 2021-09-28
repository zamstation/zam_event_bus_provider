# Event Bus Provider

A flutter provider that passes `EventBus` down to all the widgets.

***NOTE:** This package is an extension to `zam_event_bus`.*

## What's inside the package

Includes the following core components.

  * [EventBusProvider](https://pub.dev/documentation/zam_event_bus_provider/latest/provider/EventBusProvider-class.html)

Check out all the components in detail [here](https://pub.dev/documentation/zam_event_bus_provider/latest/zam_event_bus_provider/zam_event_bus_provider-library.html)

## How to use

### Step 1: Create an EventBus

```dart
final bus = EventBus(transformers);
```
`EventBus` is from `zam_event_bus` package.

### Step 2: Provide the EventBus

```dart
final app = EventBusProvider(
  bus: bus,
  child: MaterialApp(
    home: MyHomePage(title: 'Event Bus Demo'),
  ),
);
runApp(app);  
```

Add `EventBusProvider` before `MaterialApp` so that it is made available to all the routes.

### Step 3: Use context to dispatch events

```dart
FloatingActionButton(
  onPressed: () => context.dispatch(IncrementEvent()),
  tooltip: 'Increment',
  child: const Icon(Icons.add),
),
```

### Step 4: Wrap your widget with View widget to listen to data

```dart
View<Counter>(
  builder: (data) => Text(
    data.value.toString(),
    style: Theme.of(context).textTheme.headline4,
  ),
)
```
You can also use `StreamBuilder` to listen to data.

```dart
StreamBuilder<Counter>(
  initialData: context.fetch<Counter>(),
  stream: context.select<Counter>(),
  builder: (context, snapshot) {
    final counterText = snapshot.data!.value.toString();
    return Text(
      counterText,
      style: Theme.of(context).textTheme.headline4,
    );
  },
)
```
Or you can create a widget extending `DataWidget`.

```dart
class CounterText extends DataWidget<Counter> {
  @override
  Widget buildUsingData(BuildContext context, Counter data) {
    return Text(
      'Inheritance: ${data.value.toString()}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
```

To learn more, move on to the [example section](https://pub.dev/packages/zam_event_bus_provider/example) or check out these dedicated [examples in github](https://github.com/zamstation/zam_event_bus_provider/blob/main/example/lib).

## Status
[![Build](https://github.com/zamstation/zam_event_bus_provider/actions/workflows/build_workflow.yaml/badge.svg)](https://github.com/zamstation/zam_event_bus_provider/actions/workflows/build_workflow.yaml)

## Contributors
- [Amsakanna](https://github.com/amsakanna)

## License
[BSD 3-Clause License](https://github.com/zamstation/zam_event_bus_provider/blob/main/LICENSE)
