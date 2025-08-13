import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coin.dart';

class ApiService {
  static const baseUrl = 'https://api.coingecko.com/api/v3';

  static Future<List<Coin>> fetchTopCoins() async {
    final url = Uri.parse('$baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Coin.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
