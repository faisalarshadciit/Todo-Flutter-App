import 'package:flutter/material.dart';
import 'package:todo_app/model/todoItem.dart';
import 'package:todo_app/utils/database_client.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  var db = new DatabaseHelper();
  final List<ToDoItem> _itemList = <ToDoItem>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                return new Card(
                  color: Colors.white10,
                  child: ListTile(
                    title: _itemList[index],
                    // onLongPress: () => updateItem(_itemList[index], index),
                    trailing: Listener(
                      key: Key(_itemList[index].itemName),
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                      ),
                      // onPointerDown: (pointerEvent) =>
                      //     deleteToDo(_itemList[index].id),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add Item',
          backgroundColor: Colors.redAccent,
          child: ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: _showFormDialog),
    );
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(
                // border: OutlineInputBorder(),
                labelText: 'Item',
                hintText: 'Enter Item Name',
                icon: Icon(Icons.note_add)),
          ))
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        FlatButton(
            onPressed: () {
              handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text('Save'))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void handleSubmitted(String text) async {
    print('handleSubmitted called....');
    _textEditingController.clear();

    ToDoItem toDoItem = ToDoItem(text, DateTime.now().toIso8601String());
    int savedItemID = await db.saveItem(toDoItem);
    print('item saved....');

    ToDoItem addedItem = await db.getItem(savedItemID);

    setState(() {
      _itemList.insert(0, addedItem);
    });
  }
}
