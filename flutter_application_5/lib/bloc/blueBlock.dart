import 'package:flutter_bloc/flutter_bloc.dart';

class BlueState {
  int amount;

  BlueState({this.amount = 0});
}

abstract class BlueEvent {}

class MuitoBlue extends BlueEvent {}

class NormalBlue extends BlueEvent {}

class PoucoBlue extends BlueEvent {}

class SemBlue extends BlueEvent {}

class BlueBloc extends Bloc<BlueEvent, BlueState> {
  BlueBloc() : super(BlueState(amount: 40)) {
    on<SemBlue>(semBlue);
    on<PoucoBlue>((event, emit) => emit(BlueState(amount: 60))); // Melhor escrever funções anônimas assim
    on<NormalBlue>((event, emit) => emit(BlueState(amount: 150)));
    on<MuitoBlue>((event, emit) => emit(BlueState(amount: 255)));
  }

  semBlue(BlueEvent event, Emitter emit) {
    emit(BlueState(amount: 0));
  }
}
