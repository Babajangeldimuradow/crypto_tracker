import 'package:flutter/material.dart';
import '../models/coin.dart';
import '../services/api_service.dart';

class CoinProvider with ChangeNotifier {
  List<Coin> _coins = [];
  bool _isLoading = false;

  List<Coin> get coins => _coins;
  bool get isLoading => _isLoading;

  Future<void> loadCoins() async {
    _isLoading = true;
    notifyListeners();

    _coins = await ApiService.fetchTopCoins();

    _isLoading = false;
    notifyListeners();
  }
}
