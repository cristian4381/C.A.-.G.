import 'package:ca_and_g/blocs/blocs.dart';
import 'package:ca_and_g/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool errorConfirmPassword = false;
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    //final ViviendaBloc viviendaBloc  = BlocProvider.of<ViviendaBloc>(context,listen: false);
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context, listen:  false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cambiar contraseña'
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if(state.estadoCambioPassword == 3){
            //contraseña cambiada mandar al login
            showDialog(
              context: context,
              builder: (context) =>  InformDialog(
                title: 'Exito', 
                content: 'Se cambio la contraseña correctamente', 
                onPressed: (){
                  userBloc.add(LogoutUserEvent());
                  Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
                }
              )
            );
            
            
          }
          if(state.estadoCambioPassword == 4){
            //la contraseña alctual no es valdia
            showDialog(
              context: context,
              builder: (context) =>  InformDialog(
                title: 'Error', 
                content: 'La contraseña actual es incorrecta', 
                onPressed: (){
                  userBloc.add(ActualizarEstadoCambioPasswordEvent(1));
                }
              )
            );
            
            
          }
          if(state.estadoCambioPassword == 5){
            //servidor no disponible
            showDialog(
              context: context,
              builder: (context) =>  InformDialog(
                title: 'Error', 
                content: 'El servicio no esta diponible, intente mas tarde', 
                onPressed: (){
                  userBloc.add(ActualizarEstadoCambioPasswordEvent(1));
                }
              )
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *0.9,
                  child: Column(
                    children: [
                       Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MostrarInformacionExpandible(
                            contenido: 'Al momento de cambiar la contraseña se cerrará la sesión actual',
                            titulo: 'Nota',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            CustomInput(
                              hintText: 'Contraseña actual', 
                              prefix: Icons.password, 
                              textController: _oldPassword,
                              suffixIcon:IconButton(
                                onPressed: () => setState( () => obscureOldPassword = !obscureOldPassword), 
                                icon: Icon(obscureOldPassword ? Icons.visibility : Icons.visibility_off),
                              ),
                              obscureText: obscureOldPassword,
                            ),
                            CustomInput(
                              hintText: 'Nueva contraseña', 
                              prefix: Icons.password, 
                              textController: _newPassword,
                              suffixIcon: IconButton(
                                onPressed: () => setState( () => obscureNewPassword = !obscureNewPassword), 
                                icon: Icon(obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                              ),
                              obscureText: obscureNewPassword,
                            ),
                            CustomInput(
                              hintText: 'Confirmar nueva contraseña', 
                              prefix: Icons.password, 
                              textController: _confirmPassword,
                              obscureText: obscureConfirmPassword,
                              suffixIcon: IconButton(
                                onPressed: () => setState( () => obscureConfirmPassword = !obscureConfirmPassword), 
                                icon: Icon(obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            BtnBlue(
                              texto: 'Cambiar contraseña', 
                              onPressed: state.estadoCambioPassword==2 ? null : () async{
                                if(await _validarCampos()){
                                  userBloc.add(CambiarPasswordEvent(
                                    actualPassword: _oldPassword.text.trim(), 
                                    nuevoPassword: _newPassword.text.trim(),
                                  ));
                                }
                              }
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              )
            );
          },
        ),
      )
    );
  }
  Future<bool> _validarCampos() async{

    if(_oldPassword.text.trim().isEmpty){
      debugPrint(_oldPassword.text);
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Ingrese la contraseña actual',
          onPressed: (){},
        )
      );
      
      return false;
    }

    if(_newPassword.text.trim().isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Ingrese la nueva contraseña',
          onPressed: (){},
        )
      );
      return false;
    }

    if(_confirmPassword.text.trim().isEmpty){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Ingrese la contraseña de confirmacion',
          onPressed: (){},
        )
      );

      return false;
    }

    if(_confirmPassword.text.trim() != _newPassword.text.trim()){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'Las contraseñas no coinciden',
          onPressed: (){},
        )
      );
      return false;
    }

    if(_oldPassword.text.trim().length<8 || _newPassword.text.trim().length<8 || _confirmPassword.text.trim().length<8){
      showDialog(
        context: context,
        builder: (context) =>  InformDialog(
          title: 'Error', 
          content: 'La contraseña debe tener minimo 8 caracteres',
          onPressed: (){},
        )
      );
      return false;
    }

    return true;
  }

  
}