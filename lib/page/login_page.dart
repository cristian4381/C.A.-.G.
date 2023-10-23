import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../helpers/show_alert.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
   
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if(state.authenticatedFaild && !state.existUser){
            showAlert(context, "Error", 'Revise los datos');
            context.read<UserBloc>().add(AutenticationFaild());
          }
          if(!state.authenticatedFaild && state.existUser){
            Navigator.pushReplacementNamed(context, 'home');
          }
        },
        child: const Login(),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height *0.9,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Logo(titulo: 'C.A.&G.'),
              Form(),
              Labels(ruta: 'register', texto: 'Crea una ahora!',titulo: '¿No tienes cuenta?'),
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
    );
  }
}

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children:[
                CustomInput(
                  hintText: 'Email', 
                  keyboardType: TextInputType.emailAddress, 
                  obscureText: false, 
                  prefix: Icons.email,
                  textController: email),
                CustomInput(
                  hintText: 'Password', 
                  obscureText: true, 
                  prefix: Icons.key,
                  textController: password,
                ),
                BtnBlue(
                  texto: 'Iniciar Sesion',
                  onPressed: (state.isConnectedToInternet && state.isConnectedToServer)
                  ?(){
                    BlocProvider.of<UserBloc>(context,listen: false)
                    .add(AutenticateUserEvent(email: email.text, password: password.text));
                  }
                  :null
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



