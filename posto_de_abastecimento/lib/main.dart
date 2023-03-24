import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(
    title: "Gasolina x Alcool",
  ));
}

class MyApp extends StatefulWidget {
  final title;
  const MyApp({super.key, this.title = ''});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _textEditingControllerGasolina =
      TextEditingController();
  final TextEditingController _textEditingControllerAlcool =
      TextEditingController();
  var abastecimentoIdeal = '';
  double resultado = 0;

  void _calcular() {
    setState(() {
      var valorAlcool = double.parse(_textEditingControllerAlcool.text);
      var valorGasolina = double.parse(_textEditingControllerGasolina.text);
      resultado = valorAlcool / valorGasolina * 100;

      if (resultado >= 70) {
        abastecimentoIdeal = "-> Abastecer com Alcool";
      } else {
        abastecimentoIdeal = "-> Abastecer com Gasolina";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Gasolina vs Alcool"),
            ),
            Image.asset(
              "images/icone_bomba_combustivel.jpg",
              width: 300.0,
              height: 300.0,
            ),
            Container(
              width: 300.0,
              margin: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Valor da gasolina"),
                ),
                controller: _textEditingControllerGasolina,
              ),
            ),
            Container(
              width: 300.0,
              margin: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Valor do alcool"),
                ),
                controller: _textEditingControllerAlcool,
              ),
            ),
            ElevatedButton(
              child: Text("Calcular"),
              onPressed: _calcular,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "Resultado: ${resultado.toStringAsFixed(1)} $abastecimentoIdeal"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
