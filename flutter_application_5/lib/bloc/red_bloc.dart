import 'package:flutter_bloc/flutter_bloc.dart';

class RedState {
  int amount;

  RedState({this.amount = 0});
}

abstract class RedEvent {}

class MuitoRed extends RedEvent {}

class NormalRed extends RedEvent {}

class PoucoRed extends RedEvent {}

class SemRed extends RedEvent {}

class RedBloc extends Bloc<RedEvent, RedState> {
  RedBloc() : super(RedState(amount: 40)) {
    on<SemRed>(semRed);
    on<PoucoRed>((event, emit) => emit(RedState(amount: 60))); // Melhor escrever funções anônimas assim
    on<NormalRed>((event, emit) => emit(RedState(amount: 150)));
    on<MuitoRed>((event, emit) => emit(RedState(amount: 255)));
  }

  semRed(RedEvent event, Emitter emit) {
    emit(RedState(amount: 0));
  }
}
