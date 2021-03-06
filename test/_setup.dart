import 'package:flutter/material.dart';
import 'package:zam_event_bus/zam_event_bus.dart';
import 'package:zam_event_bus_provider/zam_event_bus_provider.dart';

///
/// The Domain Model
///
class Counter {
  final int value;

  const Counter([this.value = 0]);

  Counter increment() => Counter(value + 1);
}

///
/// The Event
///
class IncrementEvent {}

///
/// The Event handler
///
class IncrementUseCase extends SavingEventTransformer<IncrementEvent, Counter> {
  @override
  Counter execute(IncrementEvent event, EventBus bus) {
    final currentCounter = bus.selectFromStore<Counter>();
    final newCounter = currentCounter.increment();
    return newCounter;
  }
}

class MyApp extends StatelessWidget {
  final EventBus _bus;

  static final _transformers = <EventTransformer>[IncrementUseCase()];

  MyApp({Key? key})
      : _bus = EventBus(_transformers),
        super(key: key) {
    _bus.save(const Counter());
  }

  @override
  Widget build(BuildContext context) {
    return EventBusProvider(
      bus: _bus,
      child: const MaterialApp(
        home: MyHomePage(title: 'Event Bus Demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            View<Counter>(
              builder: (data) => Text(
                data.value.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.dispatch(IncrementEvent()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
