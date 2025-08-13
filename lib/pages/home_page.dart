import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coin_provider.dart';
import 'coin_detail.dart';  

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CoinProvider>(context, listen: false).loadCoins();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoinProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Top 10 Cryptos"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              provider.loadCoins(); 
            },
          )
        ],
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.coins.isEmpty
              ? Center(child: Text('No coins available.'))
              : ListView.builder(
                  itemCount: provider.coins.length,
                  itemBuilder: (context, index) {
                    final coin = provider.coins[index];
                    return ListTile(
                      title: Text("${coin.name} (${coin.symbol})"),
                      subtitle: Text("\$${coin.price.toStringAsFixed(2)}"),
                      trailing: Text(
                        "${coin.change24h.toStringAsFixed(2)}%",
                        style: TextStyle(
                          color: coin.change24h >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoinDetailPage(coin: coin),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
