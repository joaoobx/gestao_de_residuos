class ExitModel {
  final int? exitId;
  final String type;
  final String location;
  final double weight;
  final String supplier;
  final String mtr;
  final String cdf;
  final double revenue;
  final double cost;
  final String createdAt;

  ExitModel({
    this.exitId,
    required this.type,
    required this.location,
    required this.weight,
    required this.supplier,
    required this.mtr,
    required this.cdf,
    required this.revenue,
    required this.cost,
    required this.createdAt,
  });

  factory ExitModel.fromMap(Map<String, dynamic> json) => ExitModel(
        exitId: json["exitId"],
        type: json["type"],
        location: json["location"],
        weight: json["weight"],
        supplier: json["supplier"],
        mtr: json["mtr"],
        cdf: json["cdf"],
        revenue: json["revenue"],
        cost: json["cost"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "exitId": exitId,
        "type": type,
        "location": location,
        "weight": weight,
        "supplier": supplier,
        "mtr": mtr,
        "cdf": cdf,
        "revenue": revenue,
        "cost": cost,
        "createdAt": createdAt,
      };
}
