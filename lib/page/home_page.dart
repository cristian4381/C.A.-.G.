import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class HomePage extends StatefulWidget {
   
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child: 
          Text("Inicio")
        ),
        actions: [IconButton(onPressed: (){
          BlocProvider.of<UserBloc>(context, listen: false ).add(LogoutUserEvent());
          Navigator.pushReplacementNamed(context, 'login');
        } , icon: const Icon(Icons.logout)),],
      ),
      body: BlocBuilder<FormularioBloc, FormularioState>(
        builder: (context, state) {
          return Column(
            children: [
              //if(state.comunidadConfigurada)
                Card(child: ListTile(
                    title: const Text(" Continuar censo"),
                    trailing: const Icon(Icons.play_arrow),
                    onTap: ()=>{
                      Navigator.pushNamed(context, 'form')
                    },
                  ),
                ),
              if(state.boletas.length>0)
                Card(
                  child: ListTile(
                    title: const Text(" Sincronizar datos"),
                    trailing:const Icon(Icons.sync),
                    onTap: ()=>Navigator.pushNamed(context, 'sincronizacion'),
                  ),
                ),
              /*Card(child: ListTile(
                  title: const Text("Nuevo censo"),
                  trailing: const Icon(Icons.add),
                  onTap: ()=> Navigator.pushNamed(context, 'new'),
                ),
              ),*/
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.pushNamed(context, 'settings'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.settings),
      ),
    );
  }
}