import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/constants.dart';
import '../models/dados.dart';
import '../data/lista_dados.dart';
import '../components/restaurant_card.dart';
import '../providers/home_controller.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({Key? key}) : super(key: key);

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  List<Dados> items = listaDados;
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.verificaGanhador(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalVotantes = 100;
    int quantosVotaram =
        items.map((valor) => valor.votos).reduce((total, voto) => total + voto);
    double percentVotos = quantosVotaram / totalVotantes * 100;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 30, 0, 10),
        child: Column(children: [
          Row(children: [
            Text('FOODS',
                style: TextStyle(
                    fontSize: 20,
                    color: COR_VERDE_ESCURO,
                    fontWeight: FontWeight.w800)),
          ]),
          Row(children: [
            SizedBox(
              width: 300,
              height: 20,
              child: Row(children: [
                const Text('TOTAL DE VOTOS  ',
                    style: TextStyle(
                        fontSize: 9,
                        color: Color.fromARGB(255, 3, 162, 146),
                        fontWeight: FontWeight.w500)),
                Text('${percentVotos.toStringAsPrecision(4)}%',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 3, 162, 146),
                        fontWeight: FontWeight.w800)),
              ]),
            ),
          ]),
          const Divider(color: Colors.white),
          Column(
              children: items.map((item) {
            return RestaurantCard(item, item.maisVotado);
          }).toList()),
        ]),
      ),
    );
  }
}
