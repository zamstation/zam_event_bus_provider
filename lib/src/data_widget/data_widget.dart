import 'package:flutter/material.dart';
import '../event_bus_provider/fetch_on_build_context.extension.dart';
import '../event_bus_provider/select_on_build_context.extension.dart';

abstract class DataWidget<DATA extends Object> extends StatelessWidget {
  const DataWidget({Key? key}) : super(key: key);

  Widget buildUsingData(BuildContext context, DATA data);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DATA>(
      initialData: context.fetch<DATA>(),
      stream: context.select<DATA>(),
      builder: (context, snapshot) => buildUsingData(context, snapshot.data!),
    );
  }
}
