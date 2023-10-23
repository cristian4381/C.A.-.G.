
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ca_and_g/blocs/informacion/informacion_bloc.dart';
import 'package:ca_and_g/widgets/widgets.dart';

class Mascotas extends StatefulWidget {
  

  const Mascotas({
    super.key, 

  });

  @override
  State<Mascotas> createState() => _MascotasState();
}

class _MascotasState extends State<Mascotas> {
  final Map<int,TextEditingController> controllers = {};

  @override
  void initState() {
    /*final informacionState = BlocProvider.of<InformacionBloc>(context).state;
    for (int key in informacionState.tipoMascota!.keys) {
      final controller = TextEditingController();
      controllers.add(controller);
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InformacionBloc, InformacionState>(
      builder: (context, state) {
        
        return Card(
          child: ListTile(
            title:  const LabelCategoryForm(
                titulo: "Zoonosis", 
            ),
            subtitle: Column(
              children: [
                Column(
                  children: state.tipoMascota!.entries.map((entry) {
                    int key = entry.key;
                    String value = entry.value;
                    final control = TextEditingController();
                    controllers[entry.key]=control;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInput(
                          hintText: 'cantidad', 
                          prefix: Icons.pets, 
                          textController: controllers[key]!,
                          nota: value,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ),
                Acciones(
                  finalizar: true,
                  volver: true,
                  onPressed: () async{
                    controllers.forEach((key, value) => debugPrint(value.text));
                    debugPrint('Valores de los campos de texto: ');
                  },
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }
}