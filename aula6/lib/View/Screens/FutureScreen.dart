import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../teoria/Fibonacci.dart';

class FutureScreen extends StatelessWidget {
  const FutureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      waitProcessoLongoComMuitaCPU(context),
      waitProcessoLongoSemMuitaCPU(context),
      waitNovoIsolateProcessoLongoComMuitaCPU(context),
    ]);
  }

  Future<int> processoLongoComMuitaCPU() {
    return Future(() {
      return fibonacci(40);
    });
  }

  Future<int> processoLongoSemMuitaCPU() async {
    await Future.delayed(const Duration(seconds: 5));
    return 10;
  }

  Future<int> novoIsolateProcessoLongoComMuitaCPU() async {
    return compute(fibonacci, 45);
  }

  Widget waitProcessoLongoComMuitaCPU(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          processoLongoComMuitaCPU().then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Finalizou o processo longo com muita cpu"))));
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("continuei")));
        },
        child: const Text("waitProcessoLongoComMuitaCPU"));
  }

  Widget waitProcessoLongoSemMuitaCPU(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          processoLongoSemMuitaCPU().then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Finalizou o processo longo sem muita cpu"))));
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("continuei")));
        },
        child: const Text("waitProcessoLongoSemMuitaCPU"));
  }

  Widget waitNovoIsolateProcessoLongoComMuitaCPU(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        novoIsolateProcessoLongoComMuitaCPU().then((value) =>
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text ("Finalizou o processo longo com muita cpu em um novo isolate")
          ))
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Continuei")));
      },
      child: const Text("waitNovoIsolateProcessoLongoComMuitaCPU")
    );
  }
}
