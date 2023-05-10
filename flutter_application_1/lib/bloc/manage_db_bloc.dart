import 'package:flutter_application_1/model/note.dart';
import 'package:flutter_application_1/provider/local_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc() : super(InsertState()) {
    on<SubmitEvent>(insertNote);
  }
}

insertNote(SubmitEvent event, Emitter emit) {
  LocalDatabase.helper.insertNote(event.note);
  //ToDo: Verificar se preciso emitir estado
}

// Eventos
abstract class ManageEvent {}

class SubmitEvent extends ManageEvent {
  Note note;
  SubmitEvent({required this.note});
}

// Estados
abstract class ManageState {}

class InsertState extends ManageState {}
