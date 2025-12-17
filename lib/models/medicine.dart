class MedicineModel {
  final int id;
  final String name;
  final double price;
  final String image; // placeholder image

  MedicineModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'price': price, 'image': image};

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        image: json['image'],
      );
}
