import 'package:flutter/material.dart';
import 'package:todo_app/constantsFile.dart';
import 'package:path_provider/path_provider.dart';

class ToDoItem extends StatelessWidget {
  int _id;
  String _itemName;
  String _dateCreated;

  ToDoItem(this._itemName, this._dateCreated);

  // Mapping
  ToDoItem.map(dynamic obj) {
    this._id = obj['id'];
    this._itemName = obj['itemName'];
    this._dateCreated = obj['_dateCreated'];
  }

  // Getter Methods
  int get id => _id;
  String get itemName => _itemName;
  String get dateCreated => _dateCreated;

  // Saving Values via Map
  Map<String, dynamic> toMap() {
    print('toMap called....');
    var map = new Map<String, dynamic>();

    map['itemName'] = itemName;
    map['dateCreated'] = _dateCreated;

    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  // Values saved in ToDoItem
  ToDoItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._itemName = map['itemName'];
    this._dateCreated = map['_dateCreated'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                _itemName,
                style: kItemNameTextStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Created on: $_dateCreated',
                  style: kDateCreatedTextStyle,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
