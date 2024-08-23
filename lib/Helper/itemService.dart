import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemService {
  List<String> _items = [];
  final Function(List<String>) onUpdate;

  ItemService({required this.onUpdate});

  // Initialisiert den Service und lädt vorhandene Items aus den Shared Preferences.
  Future<void> init() async {
    _items = await loadItems();
    onUpdate(_items);
  }

  // Lädt Items aus den Shared Preferences.
  Future<List<String>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("items") ?? [];
  }

  // Fügt ein neues Item hinzu und speichert die aktualisierte Liste.
  void addItem(String item) async {
    _items.add(item);
    await saveItems();
    onUpdate(_items);
  }

  // Löscht ein Item an einem bestimmten Index und speichert die aktualisierte Liste.
  void deleteItem(int index) async {
    _items.removeAt(index);
    await saveItems();
    onUpdate(_items);
  }

  // Startet den Bearbeitungsprozess für ein Item an einem bestimmten Index.
  void startEditItem(int index, BuildContext context) {
    TextEditingController editingController =
        TextEditingController(text: _items[index]);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Task bearbeiten"),
            content: TextField(
              autofocus: true,
              controller: editingController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Abbrechen")),
              TextButton(
                  onPressed: () {
                    editItem(index, editingController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text("Speichern")),
            ],
          );
        });
  }

  // Aktualisiert ein Item an einem bestimmten Index und speichert die aktualisierte Liste.
  void editItem(int index, String newItem) async {
    _items[index] = newItem;
    await saveItems();
    onUpdate(_items);
  }

  // Speichert die aktuelle Itemliste in den Shared Preferences.
  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("items", _items);
  }
}
