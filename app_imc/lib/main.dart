import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingControllerPeso =
      TextEditingController();
  final TextEditingController _textEditingControllerAltura =
      TextEditingController();
  String info = "Info";

  double _calcular() {
    double resultado;
    double peso = double.parse(_textEditingControllerPeso.text);
    double altura = double.parse(_textEditingControllerAltura.text);

    resultado = peso / (altura * altura);
    return resultado;
  }

  void _informacao() {
    double resultado = _calcular();
    String resultadoString = resultado.toStringAsFixed(2);

    if (resultado < 18.6) {
      info = "IMC = $resultadoString – Abaixo do Peso";
    } else if (resultado >= 18.6 && resultado < 25) {
      info = "IMC = $resultadoString – Peso ideal";
    } else if (resultado >= 25 && resultado < 30) {
      info = "IMC = $resultadoString – Levemente acima do Peso";
    } else if (resultado >= 30 && resultado < 35) {
      info = "IMC = $resultadoString – Obesidade grau I";
    } else if (resultado >= 35 && resultado < 40) {
      info = "IMC = $resultadoString – Obesidade grau II";
    } else {
      info = "IMC = $resultadoString – Obesidade grau III";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.person_outline,
              size: 120.0,
              color: Colors.green,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text("Peso(kg)"),
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15.0),
                controller: _textEditingControllerPeso,
              ),
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text("Altura(cm)"),
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15.0),
                controller: _textEditingControllerAltura,
              ),
            ),
            Container(
              height: 50.0,
              width: 150.0,
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                child: const Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                onPressed: () {
                  setState(() {
                    _informacao();
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Text(
                info,
                style: const TextStyle(color: Colors.green, fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
