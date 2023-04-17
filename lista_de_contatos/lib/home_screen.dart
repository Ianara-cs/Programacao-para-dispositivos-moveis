import 'package:flutter/material.dart';
import 'package:lista_de_contatos/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allContatos = [];

  bool _isLoading = true;

  void _refreshContato() async {
    final contato = await SQLHelper.getAllContatos();
    setState(() {
      _allContatos = contato;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshContato();
  }

  Future<void> _addContato() async {
    await SQLHelper.createContato(_nomeController.text, _emailController.text);
    _refreshContato();
  }

  Future<void> _updateContato(int id) async {
    await SQLHelper.updateContato(
        id, _nomeController.text, _emailController.text);
    _refreshContato();
  }

  Future<void> _deleteContato(int id) async {
    await SQLHelper.deleteContato(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Contato deletado!"),
    ));
    _refreshContato();
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allContatos.firstWhere((element) => element[id] == id);
      _nomeController.text = existingData['nome'];
      _emailController.text = existingData['email'];
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nome",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addContato();
                  }
                  if (id != null) {
                    await _updateContato(id);
                  }

                  _nomeController.text = "";
                  _emailController.text = "";

                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Adicionar Contato" : "Atualizar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
              itemCount: _allContatos.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.all(15),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          _allContatos[index]['nome'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      subtitle: Text(_allContatos[index]["email"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showBottomSheet(_allContatos[index]['id']);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.indigo,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteContato(_allContatos[index]['id']);
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
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
