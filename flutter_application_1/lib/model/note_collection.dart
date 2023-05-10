import 'note.dart';

class NoteCollection {
  List<Note> noteList = List.empty();
  List<String> idList = List.empty();

  int length() {
    return noteList.length;
  }

  int getIndexOfId(String id) {
    return idList.indexOf(id);
  }

  String getIdByIndex(int index) {
    return idList[index];
  }

  Note getNoteById(String id) {
    Note note = noteList[getIndexOfId(id)];
    return Note.withData(title: note.title, description: note.description);
  }

  Note getNoteByIndex(int index) {
    Note note = noteList[index];
    return Note.withData(title: note.title, description: note.description);
  }

  updateOrInsertNoteOfId(String id, Note note){
    int index = getIndexOfId(id);
    if(index != -1){
      
    } else {

    }
  }

  deleteNoteOfId(String id, Note note){

  }

  insertNoteOfId(String id, Note note){
    
  }
}
