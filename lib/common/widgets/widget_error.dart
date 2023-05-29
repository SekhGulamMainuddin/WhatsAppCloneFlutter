import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  const WidgetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Page does not exists"),
    );
  }
}
