import 'package:flutter/material.dart';
import 'package:zam_event_bus_provider/zam_event_bus_provider.dart';
import 'package:zam_event_bus/zam_event_bus.dart';

///
/// The Domain Model.
///
class Counter {
  final int value;

  const Counter([this.value = 0]);

  Counter increment() => Counter(value + 1);
}

///
/// InitializeEvent and its Handler.
///
class InitializeEvent {}

Counter transformInitializeEvent(InitializeEvent event) {
  return Counter();
}

///
/// IncrementEvent and its Handler.
///
class IncrementEvent {}

void handleIncrementEvent(IncrementEvent event, EventBus bus) {
  final currentCounter = bus.selectFromStore<Counter>();
  final newCounter = currentCounter.increment();
  bus.publishAndSave(newCounter);
}

void main() {
  // The setup
  final transformers = <EventTransformer>[
    SavingEventTransformer<InitializeEvent>(
        InitializeEvent, transformInitializeEvent),
    CustomEventTransformer<IncrementEvent>(
        IncrementEvent, handleIncrementEvent),
  ];
  final bus = EventBus(transformers);

  // Send out the initial events.
  bus.publish(InitializeEvent());

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

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bus = EventBusProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StreamBuilder<Counter>(
                initialData: bus.selectFromStore<Counter>(),
                stream: bus.select<Counter>(),
                builder: (context, snapshot) {
                  // IMPORTANT: Always initialize before listening.
                  // Here data will not be null since InitializeEvent
                  // is sent before initializing the app
                  // and initialData is set.
                  final counterText = snapshot.data!.value.toString();
                  return Text(
                    counterText,
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bus.publish(IncrementEvent()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
