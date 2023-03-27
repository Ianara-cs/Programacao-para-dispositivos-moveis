import 'package:app_perfil_usuario/views/PerfilView.dart';
import 'package:flutter/material.dart';

import '../model/PessoaModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //PessoaModel pessoa1 = new PessoaModel("", "");

    TextEditingController _textEditingControllerPessoaNome =
        new TextEditingController();
    TextEditingController _textEditingControllerPessoaEmail =
        new TextEditingController();

    void _cadastro() {
      PessoaModel novaPessoa = PessoaModel(
          _textEditingControllerPessoaNome.text,
          _textEditingControllerPessoaEmail.text);
      //Navigator.pushNamed(context, "/perfil", arguments: <String, String>{
      //  'nome': novaPessoa.nome,
      //  "email": novaPessoa.email,
      //});
      Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Perfil(args: novaPessoa),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Image.network(
              "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133351884-stock-illustration-default-placeholder-woman.jpg",
              width: 200.0,
              height: 200.0,
            ),
            Container(
              width: 300.0,
              margin: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Nome"),
                ),
                controller: _textEditingControllerPessoaNome,
              ),
            ),
            Container(
              width: 300.0,
              margin: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
                controller: _textEditingControllerPessoaEmail,
              ),
            ),
            ElevatedButton(
              child: Text("Enviar"),
              onPressed: _cadastro,
            ),
          ])),
    );
  }
}
