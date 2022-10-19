import 'package:flutter/material.dart';
import '../models/dados.dart';

class HomeController with ChangeNotifier {
  static HomeController instance = HomeController();

  void verificaGanhador(List items) {
    items.sort((a, b) => b.votos.compareTo(a.votos));

    Dados restaurant = items[0];

    for (var i = 0; i < items.length; i++) {
      if (items[i].votos >= restaurant.votos) {
        restaurant.votos = items[i].votos;
        items[i].maisVotado = true;
      } else {
        items[i].maisVotado = false;
      }
    }
    notifyListeners();
  }
}
