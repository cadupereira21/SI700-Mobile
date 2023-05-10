class Note {
  String title = "";
  String description = "";

  Note() {
    title = "";
    description = "";
  }

  Note.withData({this.title = "", this.description = ""});

  Note.fromMap(map) {
    title = map["title"];
    description = map["description"];
  }

  toMap() {
    return {"title": title, "description": description};
  }
}
