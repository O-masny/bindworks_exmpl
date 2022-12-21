import 'package:bindworks_exmpl/components/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/items/items.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, this.item}) : super(key: key);
  final Items? item;

  @override
  Widget build(BuildContext context) {
    final Items? args = ModalRoute.of(context)?.settings.arguments as Items?;
    return CorePage(
      Column(
        children: [
          DetailChip(
            title: 'URL',
            value: args?.url ?? '',
          ),
          DetailChip(
            title: 'Name',
            value: args?.name ?? '',
          ),
          DetailChip(
            title: 'Password',
            value: args?.password ?? '',
          )
        ],
      ),
    );
  }
}

class DetailChip extends StatefulWidget {
  const DetailChip({Key? key, this.title, this.value}) : super(key: key);
  final String? title;
  final String? value;

  @override
  State<DetailChip> createState() => _DetailChipState();
}

class _DetailChipState extends State<DetailChip> {
  @override
  Widget build(BuildContext context) {
    Future<void> _copyToClipboard(BuildContext context) async {
      await Clipboard.setData(ClipboardData(text: widget.value));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Copied to clipboard'),
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                widget.value ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              IconButton(
                  onPressed: () => _copyToClipboard(context),
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ))
            ],
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
    ;
  }
}
