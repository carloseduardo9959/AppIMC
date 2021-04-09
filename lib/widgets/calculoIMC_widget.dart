import 'dart:math';

import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController alturacontroller = TextEditingController();
  TextEditingController pesocontroller = TextEditingController();
  String _resultadoIMC;

  void _calcularIMC() {
    double altura = double.parse(alturacontroller.text) / 100.0;
    double peso = double.parse(pesocontroller.text);
    double imc = peso / pow(altura, 2);

    setState(() {
      _resultadoIMC = imc.toStringAsFixed(2) + "\n\n" + getClassificacao(imc);
    });
  }

  String getClassificacao(num imc) {
    String strClassificacao;
    if (imc < 18.6)
      strClassificacao = " Abaixo do Peso";
    else if (imc < 25)
      strClassificacao = "Peso ideal";
    else if (imc < 30)
      strClassificacao = "Levemente acima do peso";
    else if (imc < 35)
      strClassificacao = "Obesidade Grau I";
    else if (imc < 40)
      strClassificacao = "Obesidade Grau III";
    else
      strClassificacao = "Obesidade Grau III";
    return strClassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: alturacontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe a  altura" : null;
                },
                decoration: InputDecoration(
                  labelText: "Altura [cm]: ",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: pesocontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe o peso" : null;
                },
                decoration: InputDecoration(
                  labelText: "Peso [Kg]: ",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                _resultadoIMC == null ? "" : "IMC: $_resultadoIMC",
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _calcularIMC();
                  }
                },
                child: Text(
                  'Calcular',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
