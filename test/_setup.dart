import 'package:flutter/material.dart';
import 'package:zam_event_bus/zam_event_bus.dart';
import 'package:zam_event_bus_provider/zam_event_bus_provider.dart';

///
/// The Domain Model.
///
class Counter {
  final int value;

  const Counter([this.value = 0]);

  Counter increment() => Counter(value + 1);
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

class MyApp extends StatelessWidget {
  final EventBus _bus;

  static final _transformers = <EventTransformer>[
    CustomEventTransformer<IncrementEvent>(handleIncrementEvent),
  ];

  MyApp({Key? key})
      : _bus = EventBus(_transformers),
        super(key: key) {
    _bus.save(Counter());
  }

  @override
  Widget build(BuildContext context) {
    return EventBusProvider(
      bus: _bus,
      child: MaterialApp(
        home: MyHomePage(title: 'Event Bus Demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StreamBuilder<Counter>(
                initialData: context.fetch<Counter>(),
                stream: context.select<Counter>(),
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
        onPressed: () => context.dispatch(IncrementEvent()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
