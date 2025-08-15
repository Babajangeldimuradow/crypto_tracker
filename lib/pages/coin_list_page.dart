import 'package:flutter/material.dart';
import '../models/coin.dart';
import 'coin_detail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinListPage extends StatefulWidget {
  const CoinListPage({Key? key}) : super(key: key);

  @override
  State<CoinListPage> createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  List<Coin> coins = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          coins = data.map((e) => Coin.fromJson(e)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching coins: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Tracker"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchCoins,
              child: ListView.builder(
                itemCount: coins.length,
                itemBuilder: (context, index) {
                  final coin = coins[index];
                  final bool isPositive = coin.change24h >= 0;

                  return ListTile(
                    leading: Hero(
                      tag: coin.id,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          coin.symbol[0],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    title: Text(coin.name),
                    subtitle: Text("\$${coin.price.toStringAsFixed(2)}"),
                    trailing: Text(
                      "${coin.change24h.toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CoinDetailPage(coin: coin),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
