import 'package:bindworks_exmpl/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/items/items.dart';
import '../../services/storage.dart';
import '../single_item_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> items = [];
  late String name;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<List<Items>> getItems() async {
    items = await UserStorage().getPersistedItems();
    return items;
  }

  Future<User> getUser() async {
    User user = await UserStorage().getPersistedUser();
    setState(() {
      name = user.name;
    });
    return user;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/addForm');
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Password locker',
          textAlign: TextAlign.center,
        ),
        leading: Center(
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            items.isNotEmpty
                ? 'Your saved data'
                : 'Save your data for later usage!',
            style: TextStyle(color: Colors.white, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          FutureBuilder(
            future: getItems(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) => ItemRow(
                    snapshot.data[index],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class CorePage extends StatelessWidget {
  const CorePage({this.title, this.widgets, this.leading, Key? key})
      : super(key: key);
  final String? title;
  final Widget? leading;
  final List<Widget>? widgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(title ?? ''),
        leading: leading,
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
