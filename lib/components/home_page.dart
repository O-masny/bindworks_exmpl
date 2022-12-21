import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/items/items.dart';

class HomePage extends StatelessWidget {
  final Items item;

  const HomePage(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/addForm');
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Password locker',
          textAlign: TextAlign.center,
        ),
        leading: Icon(Icons.key),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class ItemsComponent extends StatefulWidget {
  const ItemsComponent({Key? key}) : super(key: key);

  @override
  State<ItemsComponent> createState() => _ItemsComponentState();
}

class _ItemsComponentState extends State<ItemsComponent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CorePage extends StatelessWidget {
  const CorePage({this.title, this.widgets, Key? key}) : super(key: key);
  final String? title;
  final List<Widget>? widgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
      ),
      body: SafeArea(
        child: Column(
          children: [widgets as Widget ],
        ),
      ),
    );
  }
}
