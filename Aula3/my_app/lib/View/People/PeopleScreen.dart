import 'package:flutter/material.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.expand(
        child: FittedBox(child: Text("Pessoas")),
      ),
    );
  }
}
