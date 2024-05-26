class NoteModel {
  final int? noteId;
  final String type;
  final String location;
  final String weight;
  final String createdAt;

  NoteModel({
    this.noteId,
    required this.type,
    required this.location,
    required this.weight,
    required this.createdAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        noteId: json["noteId"],
        type: json["type"],
        location: json["location"],
        weight: json["weight"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "noteId": noteId,
        "type": type,
        "location": location,
        "weight": weight,
        "createdAt": createdAt,
      };
}
