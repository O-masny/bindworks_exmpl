import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/items/items.dart';
import 'core_page.dart';

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
            isPassword: true,
          )
        ],
      ),
    );
  }
}

class DetailChip extends StatefulWidget {
  const DetailChip({Key? key, this.title, this.value, this.isPassword = false})
      : super(key: key);
  final String? title;
  final String? value;
  final bool isPassword;

  @override
  State<DetailChip> createState() => _DetailChipState();
}

class _DetailChipState extends State<DetailChip> {
  void _toggle() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _copyToClipboard(BuildContext context) async {
      await Clipboard.setData(ClipboardData(text: widget.value));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
        ),
      );
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
                widget.isPassword && !isTapped ? '****' : widget.value ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () => setState(
                  () {
                    widget.isPassword ? _toggle() : _copyToClipboard(context);
                  },
                ),
                child: Icon(
                  widget.isPassword ? Icons.lock : Icons.copy,
                  color: Colors.white,
                ),
              ),
              if (widget.isPassword)
                GestureDetector(
                  onTap: () => _copyToClipboard(context),
                  child: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
