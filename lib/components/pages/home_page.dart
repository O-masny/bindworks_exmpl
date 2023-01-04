import 'package:bindworks_exmpl/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/arguments/home_args.dart';
import '../../models/items/items.dart';
import '../../services/secure_storage.dart';
import '../../services/storage.dart';
import '../single_item_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.args, Key? key}) : super(key: key);
  final HomePageArgs? args;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> items = [];
  String nameID = '';
  bool transition = true;

  @override
  void initState() {
    super.initState();
    if (!(widget.args?.isFromLogin ?? false)) {
      init();
    }
  }

  Future init() async {
    await UserSecureStorage.getUsername()
        .then((username) => (username?.isNotEmpty ?? true)
            ? setState(() {
                Future.delayed(Duration(seconds: 5), () {
                  setState(() {
                    widget.args?.isFromLogin ?? false
                        ? transition = true
                        : transition = false;
                  });
                });
                nameID = username!;
              })
            : {});
  }

  static const TextStyle classic_style =
      TextStyle(color: Colors.white, fontSize: 16);

  Future<List<Items>> getItems() async {
    items = await ItemStorage().getPersistedItems();
    return items;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return transition == false
        ? Scaffold(
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
              backgroundColor: Colors.black,
              centerTitle: true,
            ),
            body: Column(
              children: [
                Text(
                  'Welcome back, $nameID',
                  style: classic_style,
                  textAlign: TextAlign.center,
                ),
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
          )
        : Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'WELCOME BALCK, $nameID',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          );
  }
}
