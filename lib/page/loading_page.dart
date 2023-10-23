import 'package:ca_and_g/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
   
  const LoadingPage({Key? key}) : super(key: key);
  
  @override
    Widget build(BuildContext context) {
      return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          !state.existUser
          ? Navigator.pushReplacementNamed(context, 'login')
          : Navigator.pushReplacementNamed(context, 'home');
        },
        child: _cargando(),
      );  
  }
}

Widget _cargando(){
  return const Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/LOGO.png'),
            height: 200,
            width: 200,
          ),
          SizedBox(height: 16),
          Text(
            'Cargando',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
          SizedBox(height: 16),
          CircularProgressIndicator()
        ],
      ),
    ),
  );
}