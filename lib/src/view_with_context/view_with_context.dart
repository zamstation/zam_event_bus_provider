import 'package:flutter/material.dart';
import '../event_bus_provider/fetch_on_build_context.extension.dart';
import '../event_bus_provider/select_on_build_context.extension.dart';

class ViewWithContext<DATA extends Object> extends StatelessWidget {
  final Widget Function(BuildContext context, DATA data) builder;

  const ViewWithContext({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DATA>(
      initialData: context.fetch<DATA>(),
      stream: context.select<DATA>(),
      builder: (context, snapshot) => builder(context, snapshot.data!),
    );
  }
}
