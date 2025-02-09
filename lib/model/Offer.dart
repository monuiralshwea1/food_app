class Offer {
  int? id;
  String? name;
  String? description;
  String? image;
  String? price;

  Offer({this.id, this.name, this.description, this.image, this.price});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
  }


}
