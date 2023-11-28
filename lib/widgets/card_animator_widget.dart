import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CardAnimatorWidget extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final double duration;
  final double heightVisible;
  const CardAnimatorWidget({
    super.key,
    required this.title,
    required this.children,
    this.heightVisible = (60 * 3) + (8 * 3),
    this.duration = 150,
  });

  @override
  State<CardAnimatorWidget> createState() => _CardAnimatorWidgetState();
}

class _CardAnimatorWidgetState extends State<CardAnimatorWidget> {
  bool isVisible = true;

  IconData getIcon() {
    return isVisible ? Icons.visibility : Icons.visibility_off;
  }

  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
          color: Colors.black87,
        );
    return Card(
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  widget.title,
                  style: styleTitle,
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(getIcon()),
                ),
              ],
            ),
          ),
          AnimatedContainer(
                  height: isVisible ? widget.heightVisible : 0,
                  duration: widget.duration.ms,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.children,
                  )).animate().scaleXY(
                delay: isVisible ? widget.duration.ms : 1.ms,
                duration: isVisible ? widget.duration.ms : 1.ms,
                begin: isVisible ? 0.0 : 1.0,
                end: isVisible ? 1.0 : 0.0,
              ),
        ],
      ),
    );
  }
}
