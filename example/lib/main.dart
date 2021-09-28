import 'package:flutter/material.dart';
import 'package:zam_event_bus_provider/zam_event_bus_provider.dart';
import 'package:zam_event_bus/zam_event_bus.dart';

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

void main() {
  // The setup
  final transformers = <EventTransformer>[IncrementUseCase()];
  final bus = EventBus(transformers);

  // Store initial data.
  bus.save(const Counter());

  // Pass in the bus and run the app.
  runApp(MyApp(bus));
}

class MyApp extends StatelessWidget {
  final EventBus bus;

  const MyApp(
    this.bus, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add EventBusProvider before MaterialApp so that
    // it is made available to all the routes.
    return EventBusProvider(
      bus: bus,
      child: const MaterialApp(
        home: HomePage(title: 'Event Bus Demo'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // You have two options to listen to data:
            const Text('You have pushed the button this many times:'),
            //   1. inheritance
            //   - Create a CounterText widget extending DataWidget
            const CounterText(),
            //   2. composition
            //   - Wrap your widget inside a View widget.
            View<Counter>(
              builder: (data) => Text(
                'Composition: ${data.value.toString()}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.dispatch(IncrementEvent()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterText extends DataWidget<Counter> {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget buildUsingData(BuildContext context, Counter data) {
    return Text(
      'Inheritance: ${data.value.toString()}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
