import 'package:flutter/material.dart';

class DynamicListView extends StatelessWidget {
  DynamicListView({super.key});

  final List texto = ["A", "B", "C", "D"];
  final List colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow
  ];
  final List icons = [
    Icons.cake,
    Icons.calendar_month_outlined,
    Icons.account_balance,
    Icons.abc
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (BuildContext context, int index) =>
        Card(
          elevation: 5,
          color: colors[index%colors.length],
          child: ListTile(
            leading: Icon(icons[index%icons.length]),
            title: Text(texto[index%texto.length])
          ),
        )
    );
  }
}
