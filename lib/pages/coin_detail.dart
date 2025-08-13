
import 'package:flutter/material.dart';
import '../models/coin.dart';

class CoinDetailPage extends StatelessWidget {
  final Coin coin;

  const CoinDetailPage({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${coin.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${coin.name} (${coin.symbol})',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Current Price: \$${coin.price.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            Text('24h Change: ${coin.change24h.toStringAsFixed(2)}%'),
            
          ],
        ),
      ),
    );
  }
}
