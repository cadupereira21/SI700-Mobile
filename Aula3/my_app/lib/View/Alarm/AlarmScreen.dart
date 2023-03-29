import 'package:flutter/material.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text("Alarme 1"),
        Text("Alarme 2"),
        Text("Alarme 3"),
      ],
    );
  }
}
