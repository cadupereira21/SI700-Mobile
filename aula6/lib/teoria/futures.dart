Future<String> f() async {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(const Duration(seconds: 5));
    print("f$i");
  }

  return "retorno de f()";
}

Future<String> g() async {
  for (int i = 0; i < 2; i++) {
    await Future.delayed(const Duration(seconds: 5));
    print("g$i");
  }
  return "retorno de g()";
}

void main() {
  var x = f();
  var y = g();

  print(x);
  print(y);

  x.then((value) => print(value));
  y.then((value) => print(value));
}
