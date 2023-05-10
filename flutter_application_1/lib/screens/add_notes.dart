import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../bloc/manage_db_bloc.dart';
import '../model/note.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final _widgetsValues = Hive.box("widgets_values");
  final _listViewData = Hive.box("list_view_data");

  List _items = [];

  _refreshListView() {
    setState(() {
      _items = _listViewData.values.toList();
    });
  }

  @override
  void initState() {
    _refreshListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          tituloFormField(),
          descriptionFormField(),
          saveElevatedButton(),
          elementsListView(),
          submitElevatedButton()
        ],
      ),
    );
  }

  Widget tituloFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: _widgetsValues.get('title'),
        decoration: InputDecoration(
            labelText: "Título",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Adicione algum título";
          }
          return null;
        },
        onSaved: (value) {},
        onChanged: (value) {
          _widgetsValues.put('title', value);
        },
      ),
    );
  }

  Widget descriptionFormField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: _widgetsValues.get('description'),
        decoration: InputDecoration(
            labelText: "Anotação",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Adicione alguma anotação";
          }
          return null;
        },
        onSaved: (value) {},
        onChanged: (value) {
          _widgetsValues.put('description', value);
        },
      ),
    );
  }

  Widget saveElevatedButton() {
    return ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            String title = _widgetsValues.get('title');
            String description = _widgetsValues.get('description');

            await _listViewData
                .add({"title": title, "description": description});
            _refreshListView();
          }
        },
        child: const Text("Save"));
  }

  Widget elementsListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, index) {
          final currentItem = _items[index];
          return Card(
              color: Colors.orange,
              elevation: 3,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(currentItem['title']),
                subtitle: Text(currentItem['description']),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            String title = _listViewData.getAt(index)['title'];
                            String description =
                                _listViewData.getAt(index)['description'];
                            await _listViewData.putAt(index, {
                              'title': "${title}_mdf",
                              'description': "${description}_mdf"
                            });
                            _refreshListView();
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await _listViewData.deleteAt(index);
                            _refreshListView();
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget submitElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          for (var element in _items) {
            Note note = Note.fromMap(element);
            BlocProvider.of<ManageBloc>(context).add(
              SubmitEvent(note: note),
            );
          }
        },
        child: const Text("Submit"));
  }
}
