import 'package:flutter/material.dart';

class _BackgroundDeleteStr {
  static const bodyBackCardDelete = 'EXCLUIR';
}

class BackgroundDeleteWidget extends StatelessWidget {
  final String? text;
  const BackgroundDeleteWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade800,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              text ?? _BackgroundDeleteStr.bodyBackCardDelete,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
