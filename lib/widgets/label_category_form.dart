import 'package:ca_and_g/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LabelCategoryForm extends StatelessWidget {
  final String titulo;
  const LabelCategoryForm({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        top: 20
      ),
      child: Center(
        child: Text(
          titulo,
          style:  TextStyle(
            color: AppTheme.textColor(context),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}