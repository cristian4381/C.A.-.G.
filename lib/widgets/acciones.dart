import 'package:ca_and_g/blocs/fumulario/formulario_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Acciones extends StatelessWidget {
  final bool finalizar; 
  final bool volver;
  final bool siguiente;
  final Future<void> Function() onPressed;
  const Acciones({
    super.key,
    this.siguiente = true, 
    required this.finalizar, 
    required this.volver, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    
    final formBloc = BlocProvider.of<FormularioBloc>(context,listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(volver)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.blue,
              shape: const StadiumBorder()
            ),
            onPressed: () async {
              debugPrint('Presionado el botón "Anterior"');
              formBloc.add(DecrementStep());
            },
            child: const  Row(children: [
              Icon(Icons.arrow_circle_left),
              SizedBox(width: 5),
              Text('Volver'),
            ]),
          ),
        const SizedBox(width: 10),
        if(!finalizar && siguiente)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.blue,
              shape: const StadiumBorder()
            ),
            onPressed: onPressed,
            child: const Row(children: [
              Text('Siguiente'),
              SizedBox(width: 5),
              Icon(Icons.arrow_circle_right)
            ]),
          ),
        if(finalizar)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.green[700],
              shape: const StadiumBorder()
            ),
            onPressed: onPressed,
            child: const  Row(children: [
              Text('Finalizar'),
              SizedBox(width: 5),
              Icon(Icons.arrow_circle_right)
            ]),
            
          ),
      ],
    );
  }
}