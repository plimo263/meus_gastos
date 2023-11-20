import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OptionMarkWidget extends StatelessWidget {
  final bool isMark;
  final Widget child;
  final Widget widgetCheck;
  final bool toBackCheck;

  const OptionMarkWidget({
    super.key,
    required this.isMark,
    required this.child,
    this.toBackCheck = false,
    this.widgetCheck = const Icon(
      Icons.check,
      color: Colors.black,
      size: 36,
    ),
  });

  List<Widget> getFieldStack() {
    final children = <Widget>[];
    final check = isMark
        ? Positioned.fill(
            child: widgetCheck,
          ).animate().scale(
              begin: const Offset(0.1, 0.1),
              end: const Offset(1, 1),
              duration: 50.ms,
            )
        : const SizedBox();
    if (toBackCheck) {
      children.add(check);
      children.add(child);
    } else {
      children.add(child);
      children.add(check);
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: getFieldStack(),
    );
  }
}
