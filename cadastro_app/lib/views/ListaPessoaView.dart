import 'package:cadastro_app/db_helper.dart';
import 'package:flutter/material.dart';

class ListaPessoaView extends StatefulWidget {
  const ListaPessoaView({super.key});

  @override
  State<ListaPessoaView> createState() => _ListaPessoaViewState();
}

class _ListaPessoaViewState extends State<ListaPessoaView> {
  List<Map<String, dynamic>> _allPessoas = [];

  bool _isLoading = true;

  void _refreshContato() async {
    final pessoas = await SQLHelper.getAllPessoas();
    setState(() {
      _allPessoas = pessoas;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshContato();
  }

  Future<void> _deletePessoa(int id) async {
    await SQLHelper.deletePessoa(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Contato deletado!"),
    ));
    _refreshContato();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allPessoas.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.all(15),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          _allPessoas[index]['nome'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      subtitle: Text(_allPessoas[index]["email"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _deletePessoa(_allPessoas[index]['id']);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
      ),
    );
  }
}
