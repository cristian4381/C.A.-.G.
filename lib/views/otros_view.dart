
import 'package:ca_and_g/blocs/connectivity/connectivity_bloc.dart';
import 'package:ca_and_g/views/ubicacion_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ca_and_g/blocs/familia/familia_bloc.dart';
import 'package:ca_and_g/blocs/fumulario/formulario_bloc.dart';
import 'package:ca_and_g/blocs/gestion_ambiental/gestion_ambiental_bloc.dart';
import 'package:ca_and_g/blocs/jefe_familia/jefe_familia_bloc.dart';
import 'package:ca_and_g/blocs/miscelaneo/miscelaneo_bloc.dart';
import 'package:ca_and_g/blocs/user/user_bloc.dart';
import 'package:ca_and_g/blocs/vivienda/vivienda_bloc.dart';
import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/widgets/widgets.dart';

class OtrosView extends StatefulWidget {
  const OtrosView({super.key});

  @override
  State<OtrosView> createState() => _OtrosViewState();
}

class _OtrosViewState extends State<OtrosView> {
  final cantidadMascota = TextEditingController();
  bool formularioMascota = false;
  bool formularioEstablecimiento = false;

  final GlobalKey<CustomDropDownState> dropdownMascotas = GlobalKey<CustomDropDownState>();
  final GlobalKey<CustomDropDownState> dropdownUbicacionMascotas = GlobalKey<CustomDropDownState>();
  final GlobalKey<CustomDropDownState> dropdownEstablecimientos = GlobalKey<CustomDropDownState>();
  
  @override
  Widget build(BuildContext context) {
    final MiscelaneoBloc miscelaneoBloc =  BlocProvider.of<MiscelaneoBloc>(context,listen: false);
    return BlocBuilder<MiscelaneoBloc, MiscelaneoState>(
      builder: (context, state) {
        Map<String, dynamic> informacion = {
          'tipo_mascota': 0,
          'ubicacion' : '',
          'cantidad'  : 0, 
          'tipo' : 0,
        };
        return Column(
          children: [
            const UbicacionView(),
            Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const LabelCategoryForm(titulo: 'Zonoosis'),
                    if(state.mascotas.isNotEmpty)
                      _mascotasAgregadas(state, miscelaneoBloc),
                    if(formularioMascota)
                      _fomularioMascotas(state, informacion),
                    _accionesFormularioMascotas(state, informacion, miscelaneoBloc)
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const LabelCategoryForm(titulo: 'Establecimientos publicos'),
                    if(state.establecimientosPublicos.isNotEmpty)
                      _establecimientosAgregados(state, miscelaneoBloc),
                    if(formularioEstablecimiento)
                      CustomDropDown(
                        options: state.tiposEstablecimientos, 
                        onChanged: ( valor){
                          informacion['tipo'] = valor;
                        }, 
                        titulo: 'Seleccione un establecimiento',
                        mostrarError: state.errores['tipo'],
                        key: dropdownEstablecimientos,
                      ),
                    _accionesFormuarioEstablecimientos(state, miscelaneoBloc, informacion)
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Acciones(
              finalizar: true,
              volver: true,
              onPressed: () async{

                FormularioBloc formularioBloc = BlocProvider.of<FormularioBloc>(context,listen: false);

                bool result = await showDialog(
                  context: context,
                  builder: (context) =>  ConfrimarEnvioDialog(
                    title: 'Confirmar',
                    comunidad: formularioBloc.state.comunidadSeleccionada.nombre,
                    sector: formularioBloc.state.sector.nombre,
                  ),
                );

                if(result){
                  final JefeFamiliaBloc jefeFamiliaBloc = BlocProvider.of<JefeFamiliaBloc>(context,listen: false);
                  final FamiliaBloc familiaBloc = BlocProvider.of<FamiliaBloc>(context,listen: false);

                  Persona jefeFamilia = jefeFamiliaBloc.state.jefeFamilia;
                  JefeFamilia detalleJefeFamilia = jefeFamiliaBloc.state.detalleJefeFamilia;
                  List<Persona> familia = familiaBloc.state.familiares;
                  GestionAmbiental gestionAmbiental = BlocProvider.of<GestionAmbientalBloc>(context,listen: false).state.gestionAmbiental;
                  Vivienda vivienda = BlocProvider.of<ViviendaBloc>(context,listen: false).state.vivienda;
                  List<Mascota> mascotas = state.mascotas;
                  List<EstablecimientosPublicos> establecimientos = state.establecimientosPublicos;
                  final ConnectivityBloc connectivityBloc = BlocProvider.of<ConnectivityBloc>(context,listen: false);

                  User usuario = BlocProvider.of<UserBloc>(context,listen: false).state.user!;

                  debugPrint('Finalizado JEFE FAMILIA => ${jefeFamilia.toString()}');
                  debugPrint('Finalizado DETALLE JEFE FAMILIA => ${detalleJefeFamilia.toString()}');
                  formularioBloc.add(
                    EnviarFormularioEvent(
                      jefeFamilia: jefeFamilia, 
                      detalleJefeFamilia: detalleJefeFamilia, 
                      familia: familia, 
                      gestionAmbiental: gestionAmbiental, 
                      vivienda: vivienda, 
                      mascotas: mascotas, 
                      establecimientos: establecimientos,
                      usuario: usuario,
                      latitud: connectivityBloc.state.latitud,
                      longitud: connectivityBloc.state.longitud,
                      noFamilia: familiaBloc.state.noFamilia
                    )
                  );
                }
                
              },
            ),
            )
            
            //const SizedBox(height: 10)
          ],
        );
      },
    );
  }

  ListView _establecimientosAgregados(MiscelaneoState state, MiscelaneoBloc miscelaneoBloc) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.establecimientosPublicos.length,
      itemBuilder: (BuildContext context, int index) {
        final EstablecimientosPublicos establecimiento = state.establecimientosPublicos[index];
        return CustomColum(
          titulo: '',
          contenido: [
            MostrarInformacion(
              titulo: 'Establecimiento ${index+1}', 
              contenido: establecimiento.nombre,
            ),
          ], 
          onPressed: () {
            miscelaneoBloc.add(EliminarEstablecimientoEvent(index));
          },
          mostrarTitulo: false,
        );
      },
    );
  }

  Row _accionesFormuarioEstablecimientos(MiscelaneoState state, MiscelaneoBloc miscelaneoBloc, Map<String, dynamic> informacion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(formularioEstablecimiento)
          CustomButton(
            texto: 'Cancelar', 
            onPressed: () => setState(() {formularioEstablecimiento = false;}), 
            color: Colors.red
          ),
        const SizedBox(width: 10),
        CustomButton(
          texto: state.establecimientosPublicos.isEmpty ? 'Agregar': 'Agregar otro \nestablecimiento', 
          onPressed: (){
            if(formularioEstablecimiento){
              miscelaneoBloc.add(AgregarEstablecimientoEvent(informacion));
              dropdownEstablecimientos.currentState?.clearSelection();
            }else{
              setState(() {
                formularioEstablecimiento = true;
              });
            }
          }, 
          color: Colors.blue
        )
      ],
    );
  }

  ListView _mascotasAgregadas(MiscelaneoState state, MiscelaneoBloc miscelaneoBloc) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.mascotas.length,
      itemBuilder: (BuildContext context, int index) {
        final Mascota mascota = state.mascotas[index];
        return CustomColum(
          titulo: 'Mascota ${index+1}',
          contenido:  [
            MostrarInformacion(
              titulo: 'Tipo Mascota', 
              contenido: mascota.nombreTipoMascota,
            ),
            MostrarInformacion(
              titulo: 'No. de mascotas', 
              contenido: mascota.cantidad.toString()
            ),
            const SizedBox(height: 16),
          ],
          onPressed: () {
            debugPrint('ELIMINAR MASCOTA');
            miscelaneoBloc.add(EliminarMascotaEvent(index));
          },
        );
      },
    );
  }

  Column _fomularioMascotas(MiscelaneoState state, Map<String, dynamic> informacion) {
    return Column(
      children: [
        CustomDropDown(
          options: state.tiposMascotas, 
          onChanged: (value){
            informacion['tipo_mascota'] = value;
          }, 
          titulo: 'Mascotas',
          mostrarError: state.errores['tipo_mascota'],
          key: dropdownMascotas,
        ),
        CustomInput(
          hintText: 'Ingrese el No. de mascotas', 
          prefix: Icons.pets, 
          textController: cantidadMascota,
          keyboardType: TextInputType.number,
          mostrarError: state.errores['cantidad'],
        ),
        CustomDropDown(
          options: state.ubicacacionMascota, 
          onChanged: (value){
            informacion['ubicacion'] = value;
          }, 
          titulo: 'ubicacion de animales domesticos',
          mostrarError: state.errores['ubicacion'],
          key: dropdownUbicacionMascotas,
        ),
      ]
    );
  }

  Row _accionesFormularioMascotas(MiscelaneoState state, Map<String, dynamic> informacion, MiscelaneoBloc miscelaneoBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(formularioMascota)
          CustomButton(
            texto: 'Cancelar', 
            onPressed: () => setState(() {formularioMascota = false;}), 
            color: Colors.red
          ),
        const SizedBox(width: 10),
        CustomButton(
          texto: state.mascotas.isEmpty ? 'Agregar': 'Agregar otra \nmascota', 
          onPressed: (){
            if(formularioMascota){
              informacion['cantidad'] = int.tryParse(cantidadMascota.text) ?? 0;
              miscelaneoBloc.add(AgregarMascotaEvent(informacion));
              dropdownMascotas.currentState?.clearSelection();
              dropdownUbicacionMascotas.currentState?.clearSelection();
              cantidadMascota.text = '';
            }else{
              setState(() {
                formularioMascota = true;
              });
            }
          }, 
          color: Colors.blue
        )
      ],
    );
  }
}



