import 'package:flutter/material.dart';
import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';
import '../providers/dados-compras.dart';
import '../providers/lista-compras.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.title,
    this.subtile,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String title;
  final String subtile;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: ListTile(
          leading: Icon(
            Icons.shopping_bag,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          subtitle: Text(subtile),
          trailing: Checkbox(
            checkColor: Theme.of(context).primaryColorLight,
            activeColor: Theme.of(context).primaryColor,
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          dense: true,
        ),
      ),
    );
  }
}

class ListaComprasScreen extends StatefulWidget {
  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  bool _isSelected = false;
  List<String> _todoItems = [];
  List<String> _descricao = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new Card(
      elevation: 6,
      child: Column(children: [
        LabeledCheckbox(
            title: todoText,
            subtile: 'descricao',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: _isSelected,
            onChanged: (bool newValue) {
              setState(() {
                _isSelected = newValue;
              });
            }),
      ]),
    );
    //   ListTile(
    //       title: new Text(todoText), onTap: () => _promptRemoveTodoItem(index));
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Compras',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
              title: new Text(
            'Adicionar item',
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          )),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                new TextField(
                  autofocus: true,
                  onSubmitted: (val) {
                    _addTodoItem(val);
                    Navigator.pop(context); // Close the add todo screen
                  },
                  decoration: new InputDecoration(
                    labelText: "Adicione um item a lista",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
                Divider(),
                new TextField(
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 100,
                  autofocus: true,
                  onSubmitted: (val) {
                    _addTodoItem(val);
                    Navigator.pop(context); // Close the add todo screen
                  },
                  decoration: new InputDecoration(
                    labelText: "Descrição",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )
              ],
            ),
          ));
    }));
  }
}
