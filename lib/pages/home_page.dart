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
  //final List<Dados> _itemsSort = <Dados>[];
  final List<Dados> items = listaDados;
  final controller = HomeController();

  void callback() {
    setState(() {
      HomeController.instance.verificaGanhador(items);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  //  ### Filtrar > 50 ###
  @override
  Widget build(BuildContext context) {
    int totalVotantes = 100;
    int quantosVotaram =
        items.map((valor) => valor.votos).reduce((total, voto) => total + voto);

    double percentVotos = quantosVotaram / totalVotantes * 100;

    //int primeiroLista = items.first.id.indexOf('');

    int maiorVoto = items
        .map((valor) => valor.votos)
        .reduce((value, element) => value > element ? value : element);

    //for (var i = 0; i < items.length; i++) {
    //quantosVotaram += this.items[i].votos;
    //quantosVotaram += items.elementAt(i).votos;
    //if (i == 0) _maisVotado = items.elementAt(i).id (equivale a items.first.id);
    //}

    setState(() {
      controller.verificaGanhador(items);
    });

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        color: Colors.grey[200],
        child: Column(
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text('FONTE: GASTRO',
                      style: TextStyle(
                          fontSize: 8,
                          color: COR_VERDE_ESCURO,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            Column(
              children: items.map((item) {
                return RestaurantCard(item, item.maisVotado, callback);
              }).toList(),
              //var botao = callBack () => print('b');
            ),

            //return RestaurantCard(lista.id, lista.nome, lista.tipo);

            // children: [

            //   GridView.builder(
            //       itemCount: 4,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 1,
            //         childAspectRatio: 3,
            //         crossAxisSpacing: 300,
            //         mainAxisSpacing: 300,
            //       ),
            //       itemBuilder: (ctx, i) => Text(items.elementAt(i).id)),
            // ],
          ],
        ),
      ),
    );
  }
}
