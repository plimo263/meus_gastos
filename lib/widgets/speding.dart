import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meus_gastos/constants/assets_path.dart';
import 'package:meus_gastos/themes/colors.dart';

class Speding extends StatelessWidget {
  const Speding({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: colorSpedingLight,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: double.maxFinite,
        child: Row(
          children: [
            Image.asset(ImagesApp.despesas),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    'Despesas',
                    maxLines: 1,
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  AutoSizeText(
                    'R\$ 1.000,00',
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
