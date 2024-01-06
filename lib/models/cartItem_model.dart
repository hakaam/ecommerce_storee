class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity; // Make quantity non-final
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
