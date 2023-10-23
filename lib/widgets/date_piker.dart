import 'package:ca_and_g/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  final String hintText;
  final String nota;
  final bool mostrarError;

  const DatePicker({super.key, 
    required this.hintText,
    this.nota = '', 
    required this.onDateSelected,
    this.mostrarError = false
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
  
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _fechaSeleccionada;

   void _mostrarDatePicker() async{

    final fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      initialEntryMode: DatePickerEntryMode.input,
      locale: const Locale("es","ES"),
    );

  
    if (fechaSeleccionada != null) {
      setState(() {
        _fechaSeleccionada = fechaSeleccionada;
        widget.onDateSelected(_fechaSeleccionada);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _mostrarDatePicker,
      child: Container(
        width: MediaQuery.of(context).size.height *0.9,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        decoration: AppTheme.containerTheme(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.mostrarError)
            Container(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: const Text(
                'Campo obligatorio',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            if (widget.nota.isNotEmpty)
              Container(
                padding: const EdgeInsets.only(top: 5, left: 15),
                child: Text(
                  widget.nota,
                  style: AppTheme.notaTheme(context),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _fechaSeleccionada != null ? DateFormat('dd/MM/yyyy').format(_fechaSeleccionada!) : 'Seleccionar fecha',
              style: TextStyle(color: AppTheme.textColor(context)),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
