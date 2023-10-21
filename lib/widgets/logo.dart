import 'package:flutter/material.dart';

import '../constants/assets_path.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImagesApp.logo);
  }
}
