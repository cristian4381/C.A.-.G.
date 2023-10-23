import 'dart:io';

class Environment{
  //Local
/*
  static String url = Platform.isAndroid 
  ? 'http://192.168.1.79:3000/'
  : 'http://localhost:3000/';


  static String apiUrl = Platform.isAndroid 
  ? 'http://192.168.1.79:3000/api'
  : 'http://localhost:3000/api';

  static String socketUrl = Platform.isAndroid 
  ? 'http://192.168.1.79:3000'
  : 'http://localhost:3000';*/

  //produccion
  static String apiUrl = Platform.isAndroid 
  ? 'http://censo.xecasoft.com/api'
  : 'http://censo.xecasoft.com/api';

  static String url = Platform.isAndroid 
  ? 'http://censo.xecasoft.com/'
  : 'http://censo.xecasoft.com/';
  
}