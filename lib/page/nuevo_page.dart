import 'package:ca_and_g/blocs/blocs.dart';
import 'package:ca_and_g/services/comunidad_services.dart';
import 'package:ca_and_g/theme/app_theme.dart';
import 'package:ca_and_g/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  int noComunidad = 0;
  int noSector = 0;
  Map<int,String> sectores = {};
  ComunidadServices comunidadService = ComunidadServices();
  final GlobalKey<CustomDropDownState> sectorKey = GlobalKey<CustomDropDownState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo censo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: BlocBuilder<FormularioBloc, FormularioState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        const LabelCategoryForm(titulo: "Seleccione la comunidad"),
                        if(state.comunidadConfigurada)
                          _Informacion(
                            comunidadSeleccionada: state.comunidadSeleccionada.nombre,
                            sectorSeleccionado: state.sector.nombre,
                          ),
                        CustomDropDown(
                          options: state.comunidades, 
                          onChanged: (valor) async{
                            noComunidad = valor;
                            sectores = await comunidadService.buscarSectores(valor);
                            setState(() {
                              sectorKey.currentState?.clearSelection();
                              noSector = 0;
                            });
                          }, 
                          titulo: 'Comunidades',
                          mostrarError: state.errores['comunidad']!,
                        ),
                        //if(integrante.containsKey('sabe_leer') && integrante['sabe_leer'] == 'si')
                        if(noComunidad>0)
                          CustomDropDown(
                            options: sectores, 
                            onChanged: (valor){
                              noSector = valor;
                            }, 
                            titulo: 'Sector',
                            mostrarError: state.errores['sector']!,
                            key: sectorKey,
                          ),
                        CustomButton(texto: 'Continuar', 
                          onPressed: (){
                            debugPrint('##### COMUNIDAD SELECCIONADA #########');
                            BlocProvider.of<FormularioBloc>(context,listen: false).add(
                              ConfiguracionEvent(
                                comunidad: noComunidad,
                                sector: noSector
                              )
                            );

                            if(noComunidad!=0 && noSector!=0){
                              Navigator.pushReplacementNamed(context, 'form');
                            }
                            

                          }, 
                          color: Colors.green
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}

class _Informacion extends StatelessWidget {
  final String comunidadSeleccionada;
  final String sectorSeleccionado;
  const _Informacion({
    required this.comunidadSeleccionada,
    required this.sectorSeleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10,),
      padding: const EdgeInsets.only(top: 20,left: 20,bottom: 20),
      decoration: AppTheme.containerTheme(context),
      child: Column(
        children: [
          MostrarInformacion(
            titulo: 'Comunidad Seleccionada', 
            contenido: comunidadSeleccionada
          ),
          SizedBox(height: 10),
          MostrarInformacion(
            titulo: 'Sector', 
            contenido: sectorSeleccionado
          ),
        ],
      ),
    );
  }
}