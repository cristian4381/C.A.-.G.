import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:ca_and_g/blocs/blocs.dart';
import 'package:ca_and_g/blocs/familia/familia_bloc.dart';
import 'package:ca_and_g/blocs/gestion_ambiental/gestion_ambiental_bloc.dart';
import 'package:ca_and_g/blocs/jefe_familia/jefe_familia_bloc.dart';
import 'package:ca_and_g/blocs/miscelaneo/miscelaneo_bloc.dart';
import 'package:ca_and_g/blocs/vivienda/vivienda_bloc.dart';
import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/views/gestion_ambienta_view.dart' as ga;
import 'package:ca_and_g/views/views.dart';
import 'package:ca_and_g/widgets/widgets.dart';


class FormPage extends StatefulWidget {
   
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FormularioBloc formularioBloc = BlocProvider.of<FormularioBloc>(context,listen: false);
    final JefeFamiliaBloc jefeFamiliaBloc  = BlocProvider.of<JefeFamiliaBloc>(context,listen: false);
    final FamiliaBloc familiaBloc  = BlocProvider.of<FamiliaBloc>(context,listen: false);
    final ViviendaBloc viviendaBloc  = BlocProvider.of<ViviendaBloc>(context,listen: false);
    final GestionAmbientalBloc gestionAmbientalBloc  = BlocProvider.of<GestionAmbientalBloc>(context,listen: false);
    final MiscelaneoBloc miscelaneoBloc  = BlocProvider.of<MiscelaneoBloc>(context,listen: false);
    final ConnectivityBloc connectivityBloc = BlocProvider.of<ConnectivityBloc>(context,listen: false);


    return  Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
            return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.isConnectedToInternet ? 'Censo sincronizado' : 'Censo sin conexión'),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    state.isConnectedToInternet ? Icons.sync : Icons.sync_disabled,
                    color: state.isConnectedToInternet ? Colors.blue : Colors.red,
                    size: 30,
                  ),
                ),
              ],
            );
          },
        )
      ),
      body: BlocListener<FormularioBloc, FormularioState>(
        listener: (context, state) async {
          if(state.estado == 4){
            jefeFamiliaBloc.add(EliminarDatosvent());
            familiaBloc.add(EliminarFamiliaEvent());
            viviendaBloc.add(EliminarViviendaEvent());
            gestionAmbientalBloc.add(EliminarGestionAmbientalEvent());
            miscelaneoBloc.add(EliminarDatosGuardados());
            connectivityBloc.add(EliminarUbicacionGuardadaEvent());
            showDialog(
              context: context,
              builder: (context) =>  InformDialog(
                title: 'Información',
                content: 'Datos guadados correctamente!!',
                onPressed: () {
                  formularioBloc.add(ConfirmationEvent());
                },
              ),
            );
          }else if(state.estado == 3){
            bool result = await showDialog(
              context: context,
              builder: (context) => const ConfirmationDialog(
                title: 'Error de conexión',
                content: '¿Guardar datos para sincronizar más adelante?',
              ),
            );
            
            if(result){
              Persona jefeFamilia = jefeFamiliaBloc.state.jefeFamilia;
              JefeFamilia detalleJefeFamilia = jefeFamiliaBloc.state.detalleJefeFamilia;
              List<Persona> familia = familiaBloc.state.familiares;
              GestionAmbiental gestionAmbiental = gestionAmbientalBloc.state.gestionAmbiental;
              Vivienda vivienda = viviendaBloc.state.vivienda;
              List<Mascota> mascotas = miscelaneoBloc.state.mascotas;
              List<EstablecimientosPublicos> establecimientos = miscelaneoBloc.state.establecimientosPublicos;
              User usuario = BlocProvider.of<UserBloc>(context,listen: false).state.user!;
              formularioBloc.add(GuardarLocalEvent(
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
                noFamilia: familiaBloc.state.noFamilia,
              ));
            }else{
              formularioBloc.add(NoGuardarLocalEvent());
            }
          }else if(state.estado == 5){
            jefeFamiliaBloc.add(EliminarDatosvent());
            familiaBloc.add(EliminarFamiliaEvent());
            viviendaBloc.add(EliminarViviendaEvent());
            gestionAmbientalBloc.add(EliminarGestionAmbientalEvent());
            miscelaneoBloc.add(EliminarDatosGuardados());
            connectivityBloc.add(EliminarUbicacionGuardadaEvent());
            formularioBloc.add(EliminarConfiguracionEvent());
          }

          
        },
        child: BlocBuilder<FormularioBloc, FormularioState>(
              builder: (context, state) {
                if(state.noStep==0){
                  return const  ConfiguracionView();
                }
                if(state.noStep==1){
                  return const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Card(child: JefeFamiliaView())
                  );
                }
                if(state.noStep==2){
      
                  return const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: MiembroView()
                  );
                }
      
                if(state.noStep==3){
                  return const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: ga.GestionAmbiental()
                  );
                }
                if(state.noStep==4){
                  return const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: ViviendaView()
                  );
                }
                if(state.noStep==5){
                  return const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: OtrosView()
                  );
                }
                if(state.noStep==6){
                  return const EnviandoView();
                }
                return Container();
              },
            ),
      )
    );
  }
}