class RentEntity {
  RentEntity({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.imageAsset,
    this.specification,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String price;
  String rating;
  String imageAsset;
  String specification;
  DateTime createdAt;
  DateTime updatedAt;

  factory RentEntity.fromJson(Map<String, dynamic> json) => RentEntity(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"],
        imageAsset: json["image_asset"],
        specification: json["specification"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "rating": rating,
        "image_asset": imageAsset,
        "specification": specification,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
