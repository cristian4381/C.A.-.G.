import 'package:bloc/bloc.dart';
import 'package:ca_and_g/services/censo_services.dart';
import 'package:equatable/equatable.dart';
//import '../../models/models.dart';

part 'informacion_event.dart';
part 'informacion_state.dart';




class InformacionBloc extends Bloc<InformacionEvent, InformacionState> {
  final censoService = CensoServices();

  InformacionBloc() : super(const InformacionState()) {
    on<CargarInfomacionEvent>((event, emit) async{

     final informacion = await censoService.recuperarInformacion();


      final Map<int,String>  escolaridad = { for (var element in informacion.escolaridad) element.id : element.tipo };
      final Map<String, String> sabeLeer                = {'si': 'Si','no': 'No'};
      final Map<String, String> sexo                    = {'Masculino': 'Masculino','Femenino': 'Femenino'};
      final Map<int,String> abastecimientoAgua          = { for (var element in informacion.abastecimientoAgua) element.id : element.tipo };
      final Map<int,String> disposicionAguasReciduales  = { for (var element in informacion.disposicionAguasReciduales) element.id : element.tipo };
      final Map<int,String> disposicionDesechosSolidos  = { for (var element in informacion.disposicionDesechosSolidos) element.id : element.tipo };
      final Map<int,String> disposicionExcreta          = { for (var element in informacion.disposicionExcretas) element.id : element.tipo };
      final Map<int,String> ambientes                   = { for (var element in informacion.ambiente) element.id : element.tipo };
      final Map<int,String> pared                       = { for (var element in informacion.pared) element.id : element.tipo };
      final Map<int,String> piso                        = { for (var element in informacion.piso) element.id : element.tipo };
      final Map<int,String> techo                       = { for (var element in informacion.techo) element.id : element.tipo };
      final Map<int,String> tenencia                    = { for (var element in informacion.tenencia) element.id : element.tipo };
      final Map<int,String> tipoCocina                  = { for (var element in informacion.tipoCocina) element.id : element.tipo };
      final Map<int,String> ubicacionCocina             = { for (var element in informacion.ubicacionCocina) element.id : element.ubicacion};
      final Map<String, String> cielo                   = {'tiene': 'Tiene','no tiene': 'No tiene'};
      final Map<String, String> iluminacion             = {'buena': 'Buena','mala': 'Mala'};
      final Map<String, String> ventilacion             = {'buena': 'Buena','mala': 'Mala'};
      final Map<int, String> tipoMascota                = { for (var element in informacion.tipoMascota) element.id : element.tipo };
      final Map<int, String> estadoCivil                = { for (var element in informacion.estadoCivil) element.id : element.tipo };
      final Map<int, String> religion                   = { for (var element in informacion.religion) element.id : element.tipo };
      final Map<int, String> procedencia                = { for (var element in informacion.procedencia) element.id : element.tipo };


      emit(state.copyWith(
        abastecimientoAgua        : abastecimientoAgua,
        ambientes                 : ambientes,
        cielo                     : cielo,
        disposicionAguasReciduales: disposicionAguasReciduales,
        disposicionDesechosSolidos: disposicionDesechosSolidos,
        disposicionExcreta        : disposicionExcreta,
        escolaridad               : escolaridad,
        iluminacion               : iluminacion,
        pared                     : pared,
        piso                      : piso,
        sabeLeer                  : sabeLeer,
        sexo                      : sexo,
        techo                     : techo,
        tenencia                  : tenencia,
        tipoCocina                : tipoCocina,
        tipoMascota               : tipoMascota,
        ubicacionCocina           : ubicacionCocina,
        ventilacion               : ventilacion,
        estadoCivil               : estadoCivil,
        procedencia               : procedencia,
        religion                  : religion
      ));
    });
    
    //_init();
  }

 /* Future <void> _init() async{
    final InformacionResponse informacion;
    if(await censoService.existeInformacion()){
     
     add(CargarInfomacionEvent(informacion));
    }
  }*/
}
