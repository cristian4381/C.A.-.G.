import 'package:bloc/bloc.dart';
import 'package:ca_and_g/models/models.dart';
import 'package:ca_and_g/services/censo_services.dart';
import 'package:ca_and_g/services/comunidad_services.dart';
import 'package:ca_and_g/services/formulario_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'formulario_event.dart';
part 'formulario_state.dart';

class FormularioBloc extends Bloc<FormularioEvent, FormularioState> {
  final censoService = CensoServices();
  final formularioService = FormularioService();
  FormularioBloc() : super( FormularioState(
    comunidadSeleccionada: Comunidad(
      id: 0, 
      nombre: '',
      sector: []
    ),
    errores: {
      'comunidad': false,
      'sector' : false,
    },
    sector: Sector(
      id: 0, 
      nombre: '', 
      comunidad: 0
    ),
  )) {

    on<IncrementStep>((event, emit)  async{    
      if(state.noStep<5){
        final newNoStep = state.noStep + 1;
        emit(state.copyWith(noStep: newNoStep));
        debugPrint('STEP: $newNoStep');
        await formularioService.guardarNoStep(state.noStep);
      }
    });
    on<DecrementStep>((event, emit) async {
      if(state.noStep>0){
        final newNoStep = state.noStep - 1;
        debugPrint('STEP: $newNoStep');
        emit(state.copyWith(noStep: newNoStep));
        await formularioService.guardarNoStep(state.noStep);
      }
    });

    on<CargarDatosEvent>((event, emit) async {
      Map<int,String> comunidades = await formularioService.comunidades();
      debugPrint('exite comunidad: ${formularioService.comunidadGuardada}');

      emit(state.copyWith(
          noStep: event.noStep,
          comunidades: comunidades,
          sector: await formularioService.sectorGuardado(),
          comunidadSeleccionada: await formularioService.datosGuardados(),
          comunidadConfigurada: formularioService.comunidadGuardada,
          boletas: await formularioService.buscarListaBoletas(),
        )
      );
      debugPrint('DATOS CARGADOS');
    });
    
    on<ConfirmationEvent>((event, emit) async {
      await formularioService.eliminarComunidadSeleccionada();
      emit(
        state.copyWith(
          comunidadConfigurada: false,
          estado: 1,
          noStep: 0,
          comunidadSeleccionada: Comunidad(id: 0, nombre: '',sector: []),
          sector: Sector(id: 0, nombre: '', comunidad: 0)
        )
      );
      
    });
    on<ActualizarEstadoEvent>((event, emit) => emit(state.copyWith(estado: event.estado)));
    on<GuardarLocalEvent>((event, emit) async {

      Map<String, double> ubicacion = {};

      if(event.latitud!=0 && event.longitud !=0){
        ubicacion['latitud'] = event.latitud;
        ubicacion['longitud'] = event.longitud;
      }

        //guardarLocal
      Boleta boleta = Boleta(
        usuario: event.usuario.uid, 
        noFamilia: event.noFamilia, 
        comunidad: state.comunidadSeleccionada.id,
        sector: state.sector.id,
        vivienda: event.vivienda, 
        jefeFamilia: event.jefeFamilia, 
        detalleJefeFamilia: event.detalleJefeFamilia, 
        familia: event.familia, 
        mascotas: event.mascotas, 
        gestionAmbiental: event.gestionAmbiental, 
        establecimientosPublicos: event.establecimientos,
        ubicacion: ubicacion
      );
      await formularioService.actualizarListaBoletas(boleta);

        emit(state.copyWith(
          estado: 4,
          boletas: await formularioService.buscarListaBoletas()
        ));

    });
    on<NoGuardarLocalEvent>((event, emit) => emit(state.copyWith(estado: 1, noStep: 5)));
    on<ConfiguracionEvent> ((event, emit) async {
      debugPrint('GUARDAR DATOS COMUNIDAD: ${event.comunidad}, SECTOR: ${event.sector}');
      bool datosCorrecto = true;
      Map<String, bool> errores= Map.from(state.errores);

      if(event.comunidad == 0 ){
        datosCorrecto = false;
        errores['comunidad']=true;
      }else{
        errores['comunidad']=false;
      }

      if(event.sector == 0 ){
        datosCorrecto = false;
        errores['sector']=true;
        debugPrint('error sector 0');
      }else{
        errores['sector']=false;
      }


      if(!datosCorrecto){
        debugPrint('LISTA DE ERRORES CONFIGURACION: $errores');
        emit(state.copyWith(errores: errores));
      }else{
        ComunidadServices comunidadService = ComunidadServices();
        final Comunidad comunidad = Comunidad(id: event.comunidad, nombre: state.comunidades[event.comunidad]!,sector: []);
        final Sector sector = await comunidadService.buscarSector(event.comunidad, event.sector);
        await formularioService.guardarComunidadSeleccionada(comunidad, sector);
        emit(state.copyWith(
          comunidadConfigurada: true,
          comunidadSeleccionada: comunidad,
          errores: errores,
          noStep: 1,
          estado: 1,
          sector: sector
        ));
      }

    });
    on<EliminarConfiguracionEvent>((event, emit) async {
      await formularioService.eliminarComunidadSeleccionada();
      emit(
        state.copyWith(
          comunidadConfigurada: false,
          estado: 1,
          noStep: 1,
          comunidadSeleccionada: Comunidad(id: 0, nombre: '',sector: []),
          sector: Sector(id: 0, nombre: '', comunidad: 0)
        )
      );
    });

    on<SicronizarBoletasEvent>((event, emit) async {
      
      emit(state.copyWith(sincronizacionEstado: 2));

      bool sincronizacion = await censoService.sincronizarBoletas(state.boletas);

      emit(
        state.copyWith(
          sincronizacionEstado: sincronizacion ? 3 : 4
        )
      );
    });
    on<SincronizacionExitosaEvent>((event, emit) async {
      await formularioService.eliminarBoletas();
      emit(
        state.copyWith(
          sincronizacionEstado: 1,
          boletas: []
        )
      );
    });

    on<ErrorSincronizacionEvent>((event, emit) => emit(state.copyWith(sincronizacionEstado: 1)));
    on<EnviarFormularioEvent>((event, emit) async{
      /*emit(state.copyWith(
          noStep: event.noStep,
        )
      );*/
      debugPrint('ENVIANDO DATOS');
      debugPrint(event.jefeFamilia.toString());
      debugPrint(event.detalleJefeFamilia.toString());
      debugPrint(event.gestionAmbiental.toString());
      debugPrint(event.vivienda.toString());

      emit(state.copyWith(guardando: true, noStep: 6, estado: 2));
      
      /*List<Map<String, dynamic>> jsonList = event.mascotas.map((mascota) => mascota.toJson()).toList();
      debugPrint('Mascotas: $jsonList');
      debugPrint(event.establecimientos.toString());*/

      Map<String, double> ubicacion = {};
    
      if(event.latitud!=0 && event.longitud !=0){
        ubicacion['latitud'] = event.latitud;
        ubicacion['longitud'] = event.longitud;
      }

      Boleta boleta = Boleta(
        usuario: event.usuario.uid, 
        noFamilia: event.noFamilia, 
        comunidad: state.comunidadSeleccionada.id,
        sector: state.sector.id,
        vivienda: event.vivienda, 
        jefeFamilia: event.jefeFamilia, 
        detalleJefeFamilia: event.detalleJefeFamilia, 
        familia: event.familia, 
        mascotas: event.mascotas, 
        gestionAmbiental: event.gestionAmbiental, 
        establecimientosPublicos: event.establecimientos,
        ubicacion: ubicacion
      );

      bool res = await censoService.enviarFormulario(boleta: boleta);

      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        estado: res ? 4 : 3
      ));

      /*await formularioService.guardarNoStep(0);*/
    });
    on<ErrorNoComunidadEvent>((event, emit) {
      Map<String, bool> errores= Map.from(state.errores);
      errores['comunidad']=true;
      emit(state.copyWith(errores: errores));
    });
    on<ErrorNoSectorEvent>((event, emit) {
      Map<String, bool> errores= Map.from(state.errores);
      errores['sector']=true;
      emit(state.copyWith(errores: errores));
    });
    _init();
  }

  Future<void> _init() async {
    debugPrint('CARGADO DATOS');

    //int noStep = await formularioService.buscarNoStep();
    int noStep = 0; 
    add(CargarDatosEvent(

      noStep: noStep,

    ));
  }

}
