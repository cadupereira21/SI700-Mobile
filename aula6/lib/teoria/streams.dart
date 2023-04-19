// Classe que é uma stream
import 'dart:async';

class NumberStreamCreator {
  StreamController<int> _controller =
      StreamController(); // Permite enviar dados
  Stream<int> get stream => _controller
      .stream; // Permite adesão de receptores, ou seja, ouvir a stream de fora
  int count = 0;

  NumberStreamCreator() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.sink.add(count); // Envia dados
      if (count++ > 3) {
        timer.cancel();
      }
    });
  }
}


// Função que é uma stream
Stream<int> streamEnviaDados() async* {
  for (int i = 0; i <= 5; i++) {
    await Future.delayed(const Duration(seconds: 2));
    yield i; // Envia dados
  }
}

streamRecebeDados(int dado) {
  print("Recebi: $dado");
}

void main() {
  // Stream<int> stream = streamEnviaDados();
  // stream.listen((event) {
  //   streamRecebeDados(event);
  // });

  NumberStreamCreator().stream.listen((event) => print(event));
}
