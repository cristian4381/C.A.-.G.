

import 'package:ca_and_g/blocs/familia/familia_bloc.dart';
import 'package:ca_and_g/blocs/gestion_ambiental/gestion_ambiental_bloc.dart';
import 'package:ca_and_g/blocs/jefe_familia/jefe_familia_bloc.dart';
import 'package:ca_and_g/blocs/miscelaneo/miscelaneo_bloc.dart';
import 'package:ca_and_g/blocs/vivienda/vivienda_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:ca_and_g/blocs/informacion/informacion_bloc.dart';
import 'package:ca_and_g/routes/routes.dart';
import 'package:ca_and_g/theme/app_theme.dart';

import 'blocs/blocs.dart';
//import 'package:dcdg/dcdg.dart';

void main() {
  runApp (
    MultiBlocProvider(
      providers: [
        BlocProvider(create: ( contex ) => InformacionBloc()),
        BlocProvider(create: ( contex ) => ConnectivityBloc()),
        BlocProvider(create: ( contex ) => UserBloc() ),
        BlocProvider(create: ( contex ) => FormularioBloc()),
        BlocProvider(create: ( contex ) => JefeFamiliaBloc()),
        BlocProvider(create: ( contex ) => FamiliaBloc()),
        BlocProvider(create: ( contex ) => GestionAmbientalBloc()),
        BlocProvider(create: ( contex ) => ViviendaBloc()),
        BlocProvider(create: ( contex ) => MiscelaneoBloc()),
      ],
    child: const MyApp(),  
    )
  );

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),  
        Locale('ar', ''), // arabic, no country code
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      routes: appRoutes,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}