import 'package:chat/data/lista_dados.dart';
import 'package:chat/providers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../util/constants.dart';
import '../models/dados.dart';

class RestaurantCard extends StatefulWidget {
  RestaurantCard(this.item, this.maisVotado, this.callback, {Key? key})
      : super(key: key);

  final Dados item;
  bool maisVotado = false;
  VoidCallback callback;

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    double totalVotos = 0;
    bool ganhador = widget.item.maisVotado;
    final controller = HomeController();
    final List<Dados> items = listaDados;

    NumberFormat formatter = NumberFormat("##0");
    double votoIndividual = double.parse(widget.item.votos.toString());
    totalVotos += votoIndividual;

    if (widget.maisVotado) ganhador = true;

    return Row(children: [
      Stack(children: [
        Row(children: const [
          Padding(
              padding: EdgeInsets.only(left: 20.0, top: 8.0),
              child: SizedBox(height: 50, width: 200)),
        ]),
        Container(
          color: ganhador ? Colors.orange : Colors.green,
          child: Padding(
            padding: const EdgeInsets.only(left: 55.0, top: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.item.nome,
                        style: TextStyle(
                            color: ganhador ? Colors.red : COR_VERDE_ESCURO,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ]),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  width: 160,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(formatter.format(totalVotos)),
                              const Text(" VOTOS"),
                            ]),
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(children: [
          TextButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[900],
                elevation: 4,
                shadowColor: Colors.grey,
                side: const BorderSide(width: 1, color: Colors.grey)),
            onPressed: () {
              setState(() {
                widget.item.votos++;
                widget.item.maisVotado;
                //HomeController.instance.verificaGanhador(items);
                widget.callback();
              });
            },
            child: const Text('VOTAR',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ]),
      ),
    ]);
  }
}
