class EntryModel {
  final int? entryId;
  final String type;
  final String location;
  final double weight;
  final String createdAt;

  EntryModel({
    this.entryId,
    required this.type,
    required this.location,
    required this.weight,
    required this.createdAt,
  });

  factory EntryModel.fromMap(Map<String, dynamic> json) => EntryModel(
        entryId: json["entryId"],
        type: json["type"],
        location: json["location"],
        weight: json["weight"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "entryId": entryId,
        "type": type,
        "location": location,
        "weight": weight,
        "createdAt": createdAt,
      };
}
