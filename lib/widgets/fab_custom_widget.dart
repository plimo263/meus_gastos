import 'package:flutter/material.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class FabCustomWidget extends StatefulWidget {
  final List<SpeedDialChild> children;
  const FabCustomWidget({super.key, required this.children});

  @override
  State<FabCustomWidget> createState() => _FabCustomWidgetState();
}

class _FabCustomWidgetState extends State<FabCustomWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _minhaAnimacao;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _minhaAnimacao = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      labelsBackgroundColor: Theme.of(context).primaryColor,
      labelsStyle: const TextStyle(
        color: Colors.white,
      ),
      controller: _controller,
      speedDialChildren: widget.children,
      child: AnimatedIcon(
        progress: _minhaAnimacao,
        icon: AnimatedIcons.menu_close,
      ),
    );
  }
}
