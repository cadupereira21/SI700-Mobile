import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: SizedBox(
    //     width: 100,
    //     height: 100,
    //     child: FittedBox(child: Text("Contato")),
    //   ),
    // );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text("Contato 1"),
        Text("Contato 2"),
        Text("Contato 3"),
      ],
    );
  }
}
