import 'package:cadastro_app/db_helper.dart';
import 'package:cadastro_app/models/PessoaModel.dart';
import 'package:cadastro_app/views/ListaPessoaView.dart';
import 'package:flutter/material.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingControllerPessoaNome =
        new TextEditingController();
    TextEditingController _textEditingControllerPessoaEmail =
        new TextEditingController();
    TextEditingController _textEditingControllerPessoaSenha =
        new TextEditingController();

    Future<void> _cadastro() async {
      PessoaModel novaPessoa = PessoaModel(
          _textEditingControllerPessoaNome.text,
          _textEditingControllerPessoaEmail.text,
          _textEditingControllerPessoaSenha.text);

      await SQLHelper.createPessoa(
          novaPessoa.nome, novaPessoa.email, novaPessoa.senha);

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ListaPessoaView(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
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
              Container(
                width: 300.0,
                margin: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Senha"),
                  ),
                  controller: _textEditingControllerPessoaSenha,
                ),
              ),
              ElevatedButton(
                child: Text("Cadastrar"),
                onPressed: _cadastro,
              ),
            ])),
      ),
    );
  }
}
