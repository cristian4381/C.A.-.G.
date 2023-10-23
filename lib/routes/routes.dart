
import 'package:ca_and_g/page/change_password_page.dart';
import 'package:ca_and_g/page/nuevo_page.dart';
import 'package:ca_and_g/page/settings_page.dart';
import 'package:ca_and_g/page/sincronizacion_page.dart';
import 'package:flutter/material.dart';

import '../page/form_page.dart';
import '../page/home_page.dart';
import '../page/loading_page.dart';
import '../page/login_page.dart';
import '../page/register_page.dart';
final Map<String, Widget Function(BuildContext)> appRoutes ={
  'loading': (_) => const LoadingPage(),
  'login': (_)=> const LoginPage(),
  'register': (_)=> const RegisterPage(),
  'home': (_) => const HomePage(),
  'form': (_) => const FormPage(),
  'new' : (_) => const NewPage(),
  'sincronizacion' : (_) => const SincronizacionPage(),
  'settings' : (_) => const SettingPage(),
  'changePassword' : (_) => const ChangePasswordPage(),
};