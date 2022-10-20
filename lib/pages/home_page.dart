import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../util/constants.dart';
import '../models/dados.dart';
import '../data/lista_dados.dart';
import '../components/restaurant_card.dart';
import '../providers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Dados> items = listaDados;
  final controller = HomeController();

  void callback() {
    setState(() => controller.verificaGanhador(items));
  }

  @override
  Widget build(BuildContext context) {
    int totalVotantes = 100;
    int quantosVotaram =
        items.map((valor) => valor.votos).reduce((total, voto) => total + voto);

    double percentVotos = quantosVotaram / totalVotantes * 100;

    setState(() => controller.verificaGanhador(items));

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        width: 340,
        color: Colors.grey[200],
        child: Column(children: [
          Row(children: [
            Text('FOODS',
                style: TextStyle(
                    fontSize: 20,
                    color: COR_VERDE_ESCURO,
                    fontWeight: FontWeight.w800)),
            Text('  |  ',
                style: TextStyle(fontSize: 20, color: COR_VERDE_ESCURO)),
            Text('PR',
                style: TextStyle(
                    fontSize: 20,
                    color: COR_VERDE_CLARO,
                    fontWeight: FontWeight.bold)),
          ]),
          Row(children: [
            SizedBox(
              width: 330,
              height: 20,
              child: Row(children: [
                const Text('TOTAL DE VOTOS',
                    style: TextStyle(
                        fontSize: 9,
                        color: Color.fromARGB(255, 10, 120, 146),
                        fontWeight: FontWeight.w500)),
                LinearPercentIndicator(
                  width: 200.0,
                  lineHeight: 5.0,
                  percent: percentVotos / 100,
                  barRadius: const Radius.circular(33),
                  linearGradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 1, 129, 116),
                        Color.fromARGB(255, 1, 196, 177),
                      ]),
                ),
                Text('${percentVotos.toStringAsPrecision(4)}%',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 3, 162, 146),
                        fontWeight: FontWeight.w800)),
              ]),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text('FONTE: GASTRO',
                  style: TextStyle(
                      fontSize: 8,
                      color: COR_VERDE_ESCURO,
                      fontWeight: FontWeight.w500)),
            ),
          ]),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView(children: [
              Column(
                children: items.map((item) {
                  return RestaurantCard(item, item.maisVotado, callback);
                }).toList(),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
