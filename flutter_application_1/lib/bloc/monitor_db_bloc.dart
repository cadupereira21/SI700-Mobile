import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/note_collection.dart';
import '../provider/local_database.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  NoteCollection noteCollection = NoteCollection();

  MonitorBloc(MonitorState initialState) : super(initialState) {
    LocalDatabase.helper.stream.listen((event) {
      String noteId = event[0];
      if (event[1] == null) {
        noteCollection.deleteNoteOfId(noteId, event[1]);
      } else {
        noteCollection.updateOrInsertNoteOfId(noteId, event[1]);
      }
      add(UpdateList());
    });

    on<UpdateList>((event, emit) {
      emit(MonitorState(noteCollection: noteCollection));
    });
    on<AskNewList>((event, emit) async {
      noteCollection = await LocalDatabase.helper.getNoteList();
      emit(MonitorState(noteCollection: noteCollection));
    });
  }
}

abstract class MonitorEvent {}

class UpdateList extends MonitorEvent {}

class AskNewList extends MonitorEvent {}

class MonitorState {
  NoteCollection noteCollection;
  MonitorState({required this.noteCollection});
}
