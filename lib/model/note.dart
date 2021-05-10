final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id,
    number,
    time,
    isImportant,
    time,
    title,
    description
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String time = 'time';
  static final String title = 'title';
  static final String description = 'description';
}

class Note {
  final int? id;
  final DateTime createdTime;
  final bool isImportant;
  final int number;
  final String title;
  final String description;

  Note(
      {this.id,
      required this.createdTime,
     required this.isImportant,
     required this.number,
     required this.title,
     required this.description});

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.number: number,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.time: createdTime.toIso8601String(),
      };

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        number: json[NoteFields.number] as int,
        isImportant: json[NoteFields.isImportant] == 1,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );
}
