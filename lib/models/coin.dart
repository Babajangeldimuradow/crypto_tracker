class Coin {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double change24h;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change24h,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      symbol: (json['symbol'] as String).toUpperCase(),
      price: (json['current_price'] ?? 0).toDouble(),
      change24h: (json['price_change_percentage_24h'] ?? 0).toDouble(),
    );
  }
}
