import 'package:bindworks_exmpl/models/user/user.dart';
import 'package:flutter/material.dart';

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

  static const TextStyle classic_style =
  TextStyle(color: Colors.white, fontSize: 16);

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
          child: Text(name, style: classic_style),
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
            style: classic_style,
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
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) =>
                      ItemRow(snapshot.data[index], index),
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

