import 'package:flutter/material.dart';
import 'package:notes/db/notes_database.dart';
import 'package:notes/model/note.dart';
import 'package:notes/widget/note_form.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({Key? key, this.note}) : super(key: key);

  @override
  _AddEditNoteStatePage createState() => _AddEditNoteStatePage();
}

class _AddEditNoteStatePage extends State<AddEditNotePage> {
   final _formKey = GlobalKey<FormState>();
  //Key _formKey = GlobalKey<FormState>();
  late int number;
  late bool isImportant;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildButton(),
        ],
      ),
      body: Form(
        key: _formKey,
        child: NoteForm(
          title: title,
          description: description,
          isImportant: isImportant,
          number: number,
          onChangedDescription: (description) =>
              setState(() => this.description = description),
          onChangedImportant: (isImportant) =>
              setState(() => this.isImportant = isImportant),
          onChangedNumber: (number) => setState(() => this.number),
          onChangedTitle: (title) => setState(() => this.title = title),
        ),
      ),
    );
  }
   Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

     if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
