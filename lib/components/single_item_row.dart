import 'package:flutter/material.dart';

import '../models/items/items.dart';

class ItemRow extends StatelessWidget {
  const ItemRow(this.item, this.index, {Key? key}) : super(key: key);
  final Items item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: item),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                index.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                item.url,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                item.name,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
