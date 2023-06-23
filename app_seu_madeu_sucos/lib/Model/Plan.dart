class Plan {
  int? id;
  String? name;
  String? description;
  double? value;
  DateTime? lastModified;

  Plan({
     this.id,
     this.name,
     this.description,
     this.value,
     this.lastModified,
  });

  //Create getters and setters
  int? get getId => id;
  set setId(int? id) => this.id = id;
  String? get getName => name;
  set setName(String? name) => this.name = name;
  String? get getDescription => description;
  set setDescription(String? description) => this.description = description;
  double? get getValue => value;
  set setValue(double? value) => this.value = value;
  DateTime? get getLastModified => lastModified;
  set setLastModified(DateTime? lastModified) =>
      this.lastModified = lastModified;
}
