
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ca_and_g/blocs/familia/familia_bloc.dart';
import 'package:ca_and_g/blocs/fumulario/formulario_bloc.dart';
import 'package:ca_and_g/blocs/vivienda/vivienda_bloc.dart';
import 'package:ca_and_g/services/comunidad_services.dart';
import 'package:ca_and_g/theme/app_theme.dart';
import 'package:ca_and_g/widgets/widgets.dart';


class ConfiguracionView extends StatefulWidget {
  const ConfiguracionView({super.key});

  @override
  State<ConfiguracionView> createState() => _ConfiguracionViewState();
}

class _ConfiguracionViewState extends State<ConfiguracionView> {
  int noComunidad = 0;
  int noSector = 0;
  Map<int,String> sectores = {};
  ComunidadServices comunidadService = ComunidadServices();
  final GlobalKey<CustomDropDownState> sectorKey = GlobalKey<CustomDropDownState>();
  final noFamilia = TextEditingController();
  final noVivienda= TextEditingController();
  bool? formularioActivo;

  bool validarCampos(BuildContext context){
    final FamiliaBloc familiaBloc  = BlocProvider.of<FamiliaBloc>(context,listen: false);
    final ViviendaBloc viviendaBloc  = BlocProvider.of<ViviendaBloc>(context,listen: false);
    final FormularioBloc formularioBloc = BlocProvider.of<FormularioBloc>(context,listen: false);
    if(noComunidad == 0){
      formularioBloc.add(ErrorNoComunidadEvent());
      return false;
    }
    if(noSector == 0){
      formularioBloc.add(ErrorNoSectorEvent());
      return false;
    }
    if(noFamilia.text.trim().isEmpty){
      familiaBloc.add(ErroNoFamiliaEvent());
      return false;
    }
    if(noVivienda.text.trim().isEmpty){
      viviendaBloc.add(ErrorNoVivienda());
      return false;
    }
    
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: BlocBuilder<FormularioBloc, FormularioState>(
              builder: (context, state) {
                if(formularioActivo==null){
                  formularioActivo = !state.comunidadConfigurada;
                }
                return Column(
                  children: [
                    const LabelCategoryForm(titulo: "Configuracion inicial"),
                    if(state.comunidadConfigurada)
                      _Informacion(context,
                        comunidadSeleccionada: state.comunidadSeleccionada.nombre,
                        sectorSeleccionado: state.sector.nombre,
                      ),
                    /*if(!state.comunidadConfigurada)
                      _Formulario(state),*/
                    if(formularioActivo!)
                      _Formulario(state), 
                    
                    //if(noComunidad>0 || state.sector.comunidad>0)
                      
                    //if(noSector!=0 || state.sector.id>0)
                    CustomButton(texto: 'Continuar', 
                      onPressed: (){
                        final FamiliaBloc familiaBloc  = BlocProvider.of<FamiliaBloc>(context,listen: false);
                        final ViviendaBloc viviendaBloc  = BlocProvider.of<ViviendaBloc>(context,listen: false);
                        final FormularioBloc formularioBloc = BlocProvider.of<FormularioBloc>(context,listen: false);

                        if(formularioActivo! && validarCampos(context)){
                          int _noFamilia =  int.tryParse(noFamilia.text) ?? 0;
                          int _noVivienda =  int.tryParse(noVivienda.text) ?? 0;
                          debugPrint('##### CONFIGURACION INICIAL #########');
                          familiaBloc.add(GuardarNoFamiliaEvent(_noFamilia));
                          debugPrint('NO FAMILIA: $_noFamilia');
                          viviendaBloc.add(GuardarNoViviendaEvent(_noVivienda));
                          debugPrint('NO VIVIENDA: $_noVivienda');
                          formularioBloc.add(ConfiguracionEvent(comunidad: noComunidad, sector: noSector));
                        }else if(!formularioActivo! && state.comunidadConfigurada){
                          formularioBloc.add(IncrementStep());
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
      );
  }

  Column _Formulario(FormularioState state) {
    return Column(
      children: [
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
        CustomDropDown(
          options: sectores, 
          onChanged: (valor){
            noSector = valor;
            setState(() {});
          }, 
          titulo: 'Sector',
          mostrarError: state.errores['sector']!,
          key: sectorKey,
          initialValue: state.sector.id,
        ),
        InformacionDomiciliaria(noFamilia: noFamilia, noVivienda: noVivienda),
      ],
    );
  }


  Container _Informacion(BuildContext context,{ required String comunidadSeleccionada, required String sectorSeleccionado}) {
    return Container(
    margin: const EdgeInsets.only(bottom: 10,),
    padding: const EdgeInsets.all(20),
    decoration: AppTheme.containerTheme(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MostrarInformacionExpandible(
          titulo: 'Comunidad Seleccionada', 
          contenido: comunidadSeleccionada
        ),
        SizedBox(height: 10),
        MostrarInformacionExpandible(
          titulo: 'Sector', 
          contenido: sectorSeleccionado
        ),
        SizedBox(height: 10),
        BlocBuilder<FamiliaBloc, FamiliaState>(
          builder: (context, state) {
            return MostrarInformacion(
              titulo: 'No. familia', 
              contenido: state.noFamilia.toString()
            );
          },
        ),
        SizedBox(height: 10),
        BlocBuilder<ViviendaBloc, ViviendaState>(
          builder: (context, state) {
            return MostrarInformacion(
              titulo: 'No. vivienda', 
              contenido: state.vivienda.noVivienda.toString()
            );
          },
        ),
        SizedBox(height: 10),
        if(!formularioActivo!)
          CustomButton(texto: 'Editar', onPressed: () => setState(() => formularioActivo=true), color: Colors.blue),
        if(formularioActivo!)
          CustomButton(texto: 'Cancelar', onPressed: () => setState(() => formularioActivo=false), color: Colors.red),
      ],
    ),
  );
  }
}

class InformacionDomiciliaria extends StatelessWidget {
  const InformacionDomiciliaria({
    super.key,
    required this.noFamilia,
    required this.noVivienda,
  });

  final TextEditingController noFamilia;
  final TextEditingController noVivienda;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FamiliaBloc, FamiliaState>(
           builder: (context, state) {
            if(noFamilia.text.trim().isEmpty && state.noFamilia>0){
              noFamilia.text = state.noFamilia.toString();
            }
            return CustomInput(
              hintText: 'Ingrese el NO. Familia', 
              prefix: Icons.family_restroom, 
              textController: noFamilia,
              nota: 'NO. Familia',
              mostrarError: state.errores['no_Familia']!,
              keyboardType: TextInputType.number,
            );
          },
        ),
        BlocBuilder<ViviendaBloc, ViviendaState>(
          builder: (context, state) {
            if(noVivienda.text.trim().isEmpty && state.vivienda.noVivienda>0){
              noVivienda.text = state.vivienda.noVivienda.toString();
            }
            return CustomInput(
              hintText: 'Ingrese el No. Casa', 
              prefix: Icons.home_outlined, 
              textController: noVivienda, 
              nota: 'NO. Vivienda',
              mostrarError: state.errores['no_vivienda']!,
              keyboardType: TextInputType.number,
            );
          },
        ),
      ],
    );
  }
}
/*class _Acciones extends StatelessWidget {
  const _Acciones();

  @override
  Widget build(BuildContext context) {
    final FormularioBloc formularioBloc = BlocProvider.of<FormularioBloc>(context,listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          texto: 'NO', 
          onPressed: () async{
            bool result = await showDialog(
              context: context,
              builder: (context) => const ConfirmationDialog(
                title: 'Nuevo Censo',
                content: 'Se borrarán las configuraciones y datos guardados para iniciar un nuevo censo. \n\n ¿Desea continuar?',
              ),
            );

            if(result){
              Navigator.pushReplacementNamed(context, 'new');
              formularioBloc.add(ActualizarEstadoEvent(5));
            }
          }, 
          color: Colors.red
        ),    
        CustomButton(texto: 'Continuar', 
          onPressed: (){
            formularioBloc.add(IncrementStep());
          }, 
          color: Colors.green
        ),
      ],
    );
  }
}*/

/*class _Informacion extends StatelessWidget {
  final String comunidadSeleccionada;
  final String sectorSeleccionado;
  const _Informacion({
    required this.comunidadSeleccionada,
    required this.sectorSeleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return _info(context);
  }

  
}*/