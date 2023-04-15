import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocEvent.dart';
import 'ThemeState.dart';

class ThemeBloc extends Bloc<BlocEvent, ThemeState> {
  ThemeBloc(initialState):super(initialState){
    on<TurnDarkTheme>((event, emit) => emit(DarkTheme()));
    on<TurnNormalTheme>((event, emit) => emit(NormalTheme()));
  }
}