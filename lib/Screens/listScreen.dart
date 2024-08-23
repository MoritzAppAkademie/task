import 'package:flutter/material.dart';
import 'package:task/Helper/itemService.dart';

class listScreen extends StatefulWidget {
  final Function(int) updateItemCount;

  listScreen({required this.updateItemCount});

  @override
  State<listScreen> createState() => _listScreenState();
}

class _listScreenState extends State<listScreen> {
  late ItemService _itemService;
  List<String> _items = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _itemService = ItemService(onUpdate: (items) {
      setState(() {
        _items = items;
        isLoading = false;
        widget.updateItemCount(_items.length);
      });
    });
    _itemService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meine Checkliste"),
        ),
        body: isLoading
            ? Center(
                child: SizedBox(),
              )
            : Column(
                children: [
                  Expanded(
                    child: _items.isEmpty
                        ? _buildSmileyContent()
                        : _buildItemList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: "Task Hinzufügen",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              _itemService.addItem(_controller.text);
                              _controller.clear();
                            }
                          },
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _itemService.addItem(value);
                          _controller.clear();
                        }
                      },
                    ),
                  )
                ],
              ));
  }

  Widget _buildItemList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              title: Text(_items[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () =>
                          _itemService.startEditItem(index, context),
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () => _itemService.deleteItem(index),
                      icon: Icon(Icons.delete)),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

Widget _buildSmileyContent() {
  return Center(child: Placeholder());
}
