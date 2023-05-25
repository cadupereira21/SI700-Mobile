import 'package:flutter_bloc/flutter_bloc.dart';

import 'AccessEvent.dart';
import 'AccessState.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  AccessBloc(AccessState initialState) : super(initialState) {
    on<LogInButtonClick>((event, emit) => {
      emit(LoggedInState())
    });
    on<IWantToSignUpButtonClick>(((event, emit) => emit(SignUpState())));
    on<SignUpRequestSuccessfulEvent>(((event, emit) => emit(LoggedInState())));
    on<CancelSignUpButtonClick>(((event, emit) => emit(LogInState())));
  }
}