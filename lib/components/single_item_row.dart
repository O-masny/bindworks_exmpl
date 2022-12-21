import 'package:flutter/material.dart';

import '../models/items/items.dart';

class ItemRow extends StatefulWidget {
  const ItemRow(this.item, {Key? key}) : super(key: key);
  final Items item;

  @override
  State<ItemRow> createState() => _ItemRowState();
}

bool showPassword = false;

class _ItemRowState extends State<ItemRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/detail', arguments: widget.item),
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
              widget.item.url,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              widget.item.name,
              style: const TextStyle(color: Colors.white),
            ),
            showPassword
                ? Text(
                    widget.item.password,
                    style: const TextStyle(color: Colors.white),
                  )
                : GestureDetector(
                    onTap: () => setState(() {
                      showPassword = !showPassword;
                    }),
                    child: Icon(Icons.remove_red_eye),
                  ),
          ],
        ),
      ),
    );
  }
}
