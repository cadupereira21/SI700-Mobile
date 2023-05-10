import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';
import '../model/note_collection.dart';

class LocalDatabase {
  static LocalDatabase helper = LocalDatabase._createInstance();

  LocalDatabase._createInstance();

  Database? _database;

  String noteTable = "note_table";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}notes.db";

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int newVersion) {
    db.execute("""
      CREATE TABLE $noteTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colDescription TEXT
      );
      """);
  }

  /* Métodos que teremos sempre */
  insertNote(Note note) async {
    // 1 - await getter
    // 2 - await insert
    Database db = await database;
    int noteId = await db.insert(noteTable, note.toMap());
    notify("$noteId", note);
  }

  updateNote(String noteId, Note note) async {
    Database db = await database;
    await db.update(noteTable, note.toMap(),
        where: "$colId = ?", whereArgs: [noteId]);
    notify(noteId, note);
  }

  deleteNote(String noteId) async {
    Database db = await database;
    db.rawDelete("""
      DELETE FROM $noteTable WHERE  $colId = $noteId;  
      """);
    notify(noteId, null);
  }

  Future<NoteCollection> getNoteList() async {
    Database db = await database;
    var noteMapList = await db.rawQuery("""
         SELECT * FROM $noteTable;
    """);

    // List<Note> noteList = [];
    // for (int i = 0; i < noteMapList.length; i++) {
    //   noteList.add(Note.fromMap(noteMapList[i]));
    // }
    // return noteList;

    NoteCollection noteCollection = NoteCollection();
    for (int i = 0; i < noteMapList.length; i++) {
      noteCollection.insertNoteOfId(
        noteMapList[i][colId].toString(), 
        Note.fromMap(noteMapList[i]),
      );
    }
    return noteCollection;
  }

  /*
  Stream
  */
  notify(String noteId, Note? note) {
    _controller?.sink.add([noteId, note]);
  }

  Stream get stream {
    _controller ??= StreamController.broadcast();
    return _controller!.stream;
  }

  StreamController? _controller;
}
