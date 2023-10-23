import 'package:flutter/material.dart';

import 'package:ca_and_g/theme/app_theme.dart';

class Dropdown extends StatefulWidget {
  final Map<dynamic, String> options;
  final ValueChanged<dynamic> onChanged;
  final dynamic initialValue;
  final String titulo;
  final bool mostrarError;

  const Dropdown({
    super.key, 
    required this.options, 
    required this.onChanged, 
    this.initialValue, 
    required this.titulo,
    this.mostrarError = false
  });

  @override
  State<Dropdown> createState() => _DropdownState ();

}

class _DropdownState  extends State<Dropdown> {
  late dynamic selectedValue;
  bool seleccionable = true;
  @override
  void initState() {
    super.initState();

    widget.initialValue == '' || widget.initialValue == 0 
    ? selectedValue = null 
    : selectedValue = widget.initialValue;
    
  }

  @override
  void didUpdateWidget(Dropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      seleccionable = false;
      setState(() {
        selectedValue = widget.initialValue == '' ? null : widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
      decoration: AppTheme.containerTheme(context),
      child: Column(
        children: [
          if (widget.mostrarError) // Mostrar el mensaje de error si existe
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

          Container(
              padding: const EdgeInsets.only(top: 5,left: 15),
              child: Text(widget.titulo,
                style: AppTheme.notaTheme(context),
              ),
            ),
         
          DropdownButton<dynamic>(
            hint: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.info, size: 30),
                SizedBox(width: 15),
                Text('Selecciona una opción'),
              ],
            ),
            value: selectedValue,
            onChanged: (dynamic newValue) {
              setState(() {
                selectedValue = newValue!;
              });
              widget.onChanged(newValue!);
            },
            items: widget.options.entries.map<DropdownMenuItem<dynamic>>((entry) {
              return DropdownMenuItem<dynamic>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: const TextStyle(
                    fontSize: 14,
                  )
                ),
              );
            }).toList(),
            underline: Container(),
          ),
        ],
      ),
    );
  }
}