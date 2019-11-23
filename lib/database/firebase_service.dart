import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/models/item.dart';
import 'package:firebase_example/utils/constants.dart';

/// Stores all the custom colors used in this application
class FirebaseService {
  static var _databaseRef = FirebaseDatabase.instance.reference();

  ///
  static Future<void> create(Item item) async {
    final _itemRef = _databaseRef.child(FirebaseConstant.item);
    final _id = _itemRef.push().key;

    _itemRef.child(_id).set(item.toJson());
  }

  ///
  static Future<List<Item>> read() async {
    List<Item> items = [];
    final _itemRef = _databaseRef.child(FirebaseConstant.item);
    await _itemRef.once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      for (final key in value.keys) {
        Item i = Item.fromJson(snapshot.value[key]);
        items.add(i);
      }
      print(items.toString());
    });
    return items;
  }

  ///
  static Future<void> update(Item item) async {
    final _itemRef = _databaseRef.child(FirebaseConstant.item);
    _itemRef.child(item.id).update(item.toJson());
  }

  ///
  static Future<void> delete(String id) async {
    final _itemRef = _databaseRef.child(FirebaseConstant.item);
    _itemRef.child(id).remove();
  }
}
