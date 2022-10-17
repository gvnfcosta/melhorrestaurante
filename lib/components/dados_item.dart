import 'package:flutter/material.dart';
import '../models/dados.dart';

class DadosItem extends StatelessWidget {
  final Dados dados;
  const DadosItem({
    Key? key,
    required this.dados,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(dados.nome);
  }
}
