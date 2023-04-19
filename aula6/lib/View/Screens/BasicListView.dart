import 'package:flutter/material.dart';

class BasicListView extends StatelessWidget {
  const BasicListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          title: Text("Meu tile"),
          subtitle: Text("SI700 - Aula 6"),
          leading: Icon(Icons.sunny),
          trailing: Icon(Icons.sunny_snowing),
        ),
        ListTile(
          title: const Text("Meu segundo tile"),
          subtitle: const Text("ListTile clicável"),
          leading: const Icon(Icons.sunny),
          trailing: const Icon(Icons.sunny_snowing),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Meu terceiro tile"),
          subtitle: const Text("ListTile e leading clicáveis"),
          leading: GestureDetector(
              onTap: () {
                // ignore: avoid_print
                print("Gesture detector click");
              },
              child: const Icon(Icons.sunny)),
          trailing: const Icon(Icons.sunny_snowing),
          onTap: () {
            print("List tile click");
          },
        ),
        const Card(
          color: Colors.blue,
          elevation: 15,
          child: ListTile(
            title: Text("Tile dentro de card"),
            leading: Icon(Icons.feed)
          )
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.yellow, Colors.red])
          ),
          child: const ListTile(
            title: Text("Tile dentro de container"),
          ),
        ),
      ],
    );
  }
}
