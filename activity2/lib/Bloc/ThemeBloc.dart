import 'package:flutter_bloc/flutter_bloc.dart';

import 'ThemeEvent.dart';
import 'ThemeState.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(initialState):super(initialState){
    on<TurnDarkTheme>((event, emit) => emit(DarkTheme()));
    on<TurnNormalTheme>((event, emit) => emit(NormalTheme()));
  }
}