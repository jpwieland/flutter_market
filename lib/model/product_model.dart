class Product {
  String imageUrl;
  Map<String, String> name;
  double price;

  Product({required this.imageUrl, required this.name, required this.price});

  String getNome(String lingua) {
    return name[lingua] ?? name['en'] ?? 'Nome Indisponível';
  }
}
