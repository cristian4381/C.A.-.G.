import 'package:ca_and_g/blocs/blocs.dart';
import 'package:ca_and_g/helpers/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*import 'package:provider/provider.dart';

import '../helpers/mostrar_alert.dart';
import '../services/auth_services.dart';
import '../services/socket_service.dart';*/
import '../widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
   
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Registro'),
                Form(),
                Labels(ruta: 'login', texto: 'Iniciar Sesion', titulo: '¿Ya tienes cuenta?'),
                Text(
                'Terminos y condiciones de uso',
                style:  TextStyle(
                  fontWeight: FontWeight.w200
                ),
              )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {

  final name = TextEditingController();
  final email = TextEditingController();
  final cell = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final rol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    /*final authServices = Provider.of<AuthServices>(context);
    final socketServices = Provider.of<SocketServices>(context);*/
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context,listen: false);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if(state.error){
          showAlert(context, "Error", state.mensaje);
          userBloc.add(ActualizarError());
        }
        if(state.existUser){
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
        }

      },
      child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children:[
                   CustomInput(
                    hintText: 'Nombre', 
                    prefix: Icons.person,
                    textController: name,
                    mostrarError: state.errores['nombre']!,
                  ),
                  CustomInput(
                    hintText: 'Correo', 
                    keyboardType: TextInputType.emailAddress, 
                    prefix: Icons.email,
                    textController: email,
                    mostrarError: state.errores['correo']!,
                  ),
                  CustomInput(
                    hintText: 'Telefono',  
                    prefix: Icons.smartphone,
                    textController: cell,
                    mostrarError: state.errores['telefono']!,  
                  ),
                  CustomInput(
                    hintText: 'Password', 
                    obscureText: true, 
                    prefix: Icons.key,
                    textController: password,
                    mostrarError: state.errores['password']!,
                  ),
                  CustomInput(
                    hintText: 'Confirm Password', 
                    obscureText: true, 
                    prefix: Icons.key,
                    textController: confirmPassword,
                    mostrarError: state.errores['confirmPassword']!,
                  ),         
                   BtnBlue(texto: 'Registrar',
                    onPressed: state.autenticando ? null : () =>{
                      userBloc.add(
                        RegistrarEvent(
                          correo: email.text.trim(), 
                          nombre: name.text.trim(), 
                          telefono: cell.text.trim(), 
                          password: password.text.trim(), 
                          confirmPassword: confirmPassword.text.trim()
                        )
                      )
                    } /*authServices.autenticando ? null: () async{
                      FocusScope.of(context).unfocus();
                        final register = await authServices.register(
                          name.text.trim(),
                          email.text.trim(), 
                          password.text.trim(),
                          rol.text.trim()
                        );
        
                        if(mounted && !register){
                          mostrarAlerta(context, "Error ", 'El usuario ya esta registrado');
                        }else{
                          mostrarAlerta(context, "Exito ", 'Usuario registrado con exito');
                          Navigator.pushReplacementNamed(context, 'home_chat');
                          socketServices.connect();
                        }
        
                    }*/
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}