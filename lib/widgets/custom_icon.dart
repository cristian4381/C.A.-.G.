import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {

  final String tipoChat;

  const CustomIcon({super.key, required this.tipoChat}); 

  @override
  Widget build(BuildContext context) {
    return (tipoChat=='group')
    ?const Icon(
      Icons.group,
      color: Colors.white,
    ):const Icon(
      Icons.person,
      color: Colors.white,
    );
  }
}