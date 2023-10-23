import 'package:ca_and_g/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData prefix;
  final TextEditingController textController;
  final String nota;
  
  final bool mostrarError;
  final Widget? suffixIcon;
  final bool autocorrect;

  const CustomInput({
    super.key, 
    required this.hintText, 
    this.keyboardType=TextInputType.text, 
    this.obscureText=false, 
    required this.prefix, 
    required this.textController, 
    this.nota='',
    this.mostrarError = false,
    this.suffixIcon,
    this.autocorrect = false
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
      decoration: AppTheme.containerTheme(context),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mostrarError) // Mostrar el mensaje de error si existe
            Container(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: const Text(
                'Campo obligatorio',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),

          if(nota.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 5,left: 15),
              child: Text(nota,
                style: AppTheme.notaTheme(context),
              ),
            ),
          TextField(
            style: TextStyle(color: AppTheme.textColor(context)),
            controller: textController,
            autocorrect: autocorrect,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: Icon(prefix),          
              hintText: hintText,
              suffixIcon: suffixIcon
            ),        
          ),
        ],
      ),
    );
  }
}