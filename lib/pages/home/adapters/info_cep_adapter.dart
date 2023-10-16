import 'package:flutter/material.dart';

class InfoCepAdapter extends StatelessWidget {
  final String label;
  final String value;

  const InfoCepAdapter({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: '),
        const SizedBox(width: 10),
        Expanded(child: Text(value)),
      ],
    );
  }
}
