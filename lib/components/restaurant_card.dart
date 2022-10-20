import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';
import '../util/constants.dart';
import '../models/dados.dart';

class RestaurantCard extends StatefulWidget {
  const RestaurantCard(this.item, this.maisVotado, this.callback, {super.key});

  final Dados item;
  final bool maisVotado;
  final VoidCallback callback;

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    double totalVotos = 0;
    bool ganhador = widget.item.maisVotado;

    NumberFormat formatter = NumberFormat("##0");
    double votoIndividual = double.parse(widget.item.votos.toString());
    totalVotos += votoIndividual;
    double porcento = (totalVotos);

    if (widget.maisVotado) ganhador = true;

    return Row(children: [
      Stack(children: [
        Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0),
            child: Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(1),
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(-1.0, -1.0),
                        blurRadius: 1),
                  ],
                  color: ganhador ? Colors.teal[400] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(6.0)),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 60.0, top: 12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.item.nome,
                          style: TextStyle(
                              color: ganhador ? Colors.white : COR_VERDE_ESCURO,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      Text('  |  ',
                          style: TextStyle(
                              color: ganhador ? Colors.white : COR_VERDE_ESCURO,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      Text(widget.item.tipo,
                          style: TextStyle(
                              color: ganhador ? Colors.white : COR_VERDE_ESCURO,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: LinearPercentIndicator(
                      width: 210.0,
                      lineHeight: 5.0,
                      percent: porcento / 100,
                      barRadius: const Radius.circular(33),
                      progressColor: ganhador ? Colors.grey[300] : Colors.teal,
                      backgroundColor:
                          ganhador ? Colors.teal : Colors.grey[400]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${porcento.toStringAsPrecision(4)} %",
                              style: TextStyle(
                                  color: ganhador
                                      ? Colors.white
                                      : COR_VERDE_ESCURO,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(formatter.format(totalVotos),
                                    style: TextStyle(
                                        color: ganhador
                                            ? Colors.white
                                            : COR_VERDE_ESCURO,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text(" VOTOS",
                                    style: TextStyle(
                                        color: ganhador
                                            ? Colors.white
                                            : COR_VERDE_ESCURO,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500)),
                              ]),
                        ]),
                  ),
                ),
              ]),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(6.0)),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 11.0, left: 4),
          child: Container(
              height: 48,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Image.network(widget.item.imageUrl,
                  fit: BoxFit.contain, scale: 0.9)),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Row(children: [
          TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[900],
              elevation: 4,
              shadowColor: Colors.grey,
              side: const BorderSide(width: 1, color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                if (widget.item.votos < 100) {
                  widget.item.votos++;
                }
                widget.item.maisVotado;
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
